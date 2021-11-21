//
//  Tips.swift
//  Shower App
//
//  Created by Student on 15/11/21.
//
import SwiftUI
var tips = ["It is recommended to shower between 5-10 minutes for each shower",
            "Showering too much not only waste a lot of water, it will lead to dry skin and hair!",
            "Cutting back on showers would make you smell or risk having skin infections",
            "Plan your showers! Do up shower schedules based on your activities everyday!",
            "Your hair needs does not need as much as showering as your body because it is made of dead cells",
            "If you want to shave, you might want to do it last",
            "Don't rub with a towel dry but instead pat yourself with it",
            "You might want to apply moisturiser 2-3mins after shower to keep your skin plump",
            "Showering from top to bottom let the soap make its way down",
            "Focus showering in the dirtiest areas instead of your arms and legs",
            "It is better to shower in lukewarm water or cooler water as it is healthier for blood circulation",
            "You can brush your hair beforehand so you don't further tangle it when it gets wet",
            "Remember to shampoo your hair thoroughly and not just pour it on top of your head",
            "Don't overscrub your skin as although it might remove bacteria, it might irritate your skin",
            "The average American showers for eight minutes, but most people don’t need to be in the shower for that long",
             "If soap goes into eyes, immediately rinse affected eye with water",
             "Install anti-slip tiles in bathroom to prevent you from slipping",
             "Install safety handle bars if you have household members with movement difficulties",
             "Wear a shower cap to keep your hair dry",
             "While running water to wait it to heat up, you can collect it in a bucket to save water",
             "After a shower, ventilate the bathroom to bring down the room's temperature",
             "Do not apply too much soap or more water would be required to rinse off",
             "Rinse yourself slightly with water before scrubbing to save soap",
             "You can mix soap with water to save soap",
             "Do not shower directly after workout but let your sweat dry off and your body to cool down",
             "Wait for at least twenty minutes after a workout before showering",
             "It is recommended to have a cold shower after workout to reduce muscle inflammation, flush out lactic acid, and help your muscles to start the healing process after strength training",
             "Do not wait longer than a few hours after a workout to shower",
             "Showering after a workout feels relaxing and you should do so!",
             "Showering after a workout reduces the risk of rashes and breakouts that can be caused by bacteria rapidly multiplying on your skin due to your sweaty body",
             "It is recommended to shower before eating",
            "Showering right after a meal causes delay in digestion",
            "If you wish to eat before showering, wait for at least thrity to forty-five minutes before doing so",
             "Taking an evening shower is healthier than a morning one",
             "An evening shower rinses off a day's activities of stowaway germs",
             "Using a gentle, fragrance-free cleanser is best for the body",
             "Too cold showers tightens the skin's pores, which doesn’t allow the natural secretion of sebum and acne-causing bacteria",
             "Too hot showers open pores and stimulates excess sebum production that leaves it prone to further irritation",
             "Do not rinse out your conditioner at the end of the shower or it will lead to breakouts on the body",
             "If you have wounds, do not get them wet",
             "You can keep your wound dry by using a cast or wound protector",
             "If you have a wound and cannot be protected, shower instead",
             "If you have wounds on your legs or have movement difficulties, get a waterproof stool to sit on in the shower",
             "If you use a sponge or loofah, replace it every four to six weeks",
             "Sponges and loofahs have large holds to which holds onto dead skin cells",
             "Dead skin cells on sponges and loofahs promotes bacteria growth with moisture",
             "Try not to use a soap dish as it encourages bacteria to grow",
             "Try not to use scented soaps as it irritates the skin more",
             "Do not reuse dirty towels but replace them with new ones after using it two to three times",
             "Just like loofahs and sponges, towels also promote bacteria growth if not washed on a regular basis"]


struct Tips: View {
    var current_tip: Int
    
    
    var body: some View {
        VStack {
            Text("TIP 💡")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .padding()
            
            Text(tips[current_tip])
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.all, 50)

        }
        
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        Tips(current_tip: 5)
    }
}
