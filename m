Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86684C20B0
	for <lists+linux-fpga@lfdr.de>; Mon, 30 Sep 2019 14:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfI3Mik (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Sep 2019 08:38:40 -0400
Received: from sonic310-23.consmr.mail.ne1.yahoo.com ([66.163.186.204]:44645
        "EHLO sonic310-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729603AbfI3Mik (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 30 Sep 2019 08:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569847117; bh=euy9S2/4+kZy++A4IfrNsNY0nG5tpX3oraAf8XcNLZo=; h=Date:From:Reply-To:Subject:From:Subject; b=SIh/rvihzd8p9nxEAi1dJYI3S2E4SKix0BjWqtQXs1HjKl7Fztxbt2qN950uV07E9ppTmJRlF+MBcYs0R+UGpOKxaEiKmx5aBFxceqVJj5suhZ77pz6iW/B6ySZ9Gb9KeUv67PLpDyyWv7Mv9DlNMvvPQPjAKMm28uLPSxmMC/fdxbLC2VCre1I7/vsYlramCJrbdSdhqR0WOoMoMVvR/8HL2YWUnWX1dxH9ylyE+w15wHebErQubIZSIKk3uSDE+igJ88y1bbzGto+XFBzjAl3vdGOSHRFITg6JjCnj8zXRxMBFB6yq7itBh7j3a5d9AHFHwwdbVmrD2ApTae9y/Q==
X-YMail-OSG: sSIIpLkVM1mJgvJTwNuZq6AvGC_NIx.O6QnK2vmjQBaAbOvDsnATeS5Fr0lrRVb
 b8p.ihMVFseV3GK09p9hKbwayR5svM7q6HIbbcz7J79wyKYDFw836g8G8AvxaP.gloZ093Ymql0I
 jqRuL5G2kBvbL0pfmaIXqL8jAF3YLGo_9z2pTxfbqGj5dKWqk.5KqcWg0QEp1RBgzAJUXOBUzZ1c
 vD0umSe.pX4k9FoKRwQ8RjHLelYzjZ4WfheG6dl7syC0GDBJm82KNrmIFftg9loPovxp7IZNVJXe
 O6L6XwZQMAwYmUDERJJeAti4C8IySBds3aSRy6gqgiAoXW8x6t3FrRTbC95.jzJXp1tZavtCAjcE
 6RX9H2PXCeCOooyspyWjK6pu7f9Nuhh_tfA3O2ecJH4ImFqMe4fowDUU6YnVr_3twE9EAs8zqpdt
 r03kbBTHbaqS78jqocdYfv8rSNjkID6jacB3vT0nSOf1tvvVi5mZwBfcZJkCaI0CbMm6_PMqUSPS
 wO.Pzgf5rePKelPeQOUU5OJmR78qoEx0rBLWqKdukvngaj7NRaQH0Hf9LACCoH0iQPxwx8O9rcPd
 Ry0IW_OUiBQ0IQIGHtsr0d9FWpMhPotPDs.y0zE25FvdFC6YxLgIP2kYrHHMv2aMrw8xVgqKmpen
 JK7GV.EePkAgOUW12qUWc0N32sCAXiFRQyHaDwELg7u_ifVAqhDD.dTFtoyVQercpQU_9CkOzZSK
 QnEpFTh7_ESUGgl22QHzT9CR4mh9vC3x1YkU9MC.iFf4wkaTu3ay9drJ.JYbAxDFA6etRKce5XH_
 gFQuiyrBTB8FfacNje6LAWyUCbzmiCvaNTzLK0JF2P7evKsI6Tq7K7V0JyKdy4UXZ9ZeiEs3u67h
 gxmOFsinyyfXmKN8wOIPmPwFAExn6u3yjSvzUCauVQCI7HDRPW7Dv3zKVnrAWCsD8P7IxOhw3chz
 sP3x7wCTepDU9IpWjm4lb_Wgqum575Kn_a8cUsmgJyxUCpvF2oHEBuOz5Y58YYYR32vB0vWWTyp4
 uDTw0GpQsHuomDn1p7REl06oMmhkojIpgsN6hzT1ZqOJrQhACXMrwf1_qNLzl9rHnkgUGM1nyTIW
 QdZiGM0cp.yRRQXTIDoN.emNoANHnkznJNmDvSLJiuXJXfid8QIQLcI103.VtaCSM.0v28l.Q49w
 rvhHMAUst2NlGNucZTwU70uy01Xfstg9Tdsu1OU3SM2B6pZncqQ_vdHeKPqAkLVk6qybsYT08zlP
 u8EN5VnjqdGdQg4anaK9iBT3bVvbV0B5uETjbiPHUcGKws4.l37H_4CySgLwsa5cZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Mon, 30 Sep 2019 12:38:37 +0000
Date:   Mon, 30 Sep 2019 12:38:33 +0000 (UTC)
From:   "Mrs. Caroline Mark" <goshtholy7@gmail.com>
Reply-To: mrs.carolinemark@gmail.com
Message-ID: <1425884739.1385765.1569847113765@mail.yahoo.com>
Subject: Hello Dear.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hello Dear.

My name is  Mrs.carolinemark,I am 30years old  from USA united state of
American medical doctor, starting from today, I was just going through
the Internet search when your profile which i like it, all i need is
good honest  and trustworthy friend, i have an important somethings to
discus with you , which i know that is going to benefit you and i in
future.

If you are honest and trustworthy person please get back to me by  email me at

Mrs.carolinemark@gmail.com

I will be happy to see your reply for us to know each other better and
give you my pictures and details about me.

Yours
Mrs.carolinemark




