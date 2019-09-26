Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8675BF4B8
	for <lists+linux-fpga@lfdr.de>; Thu, 26 Sep 2019 16:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfIZOJu (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 26 Sep 2019 10:09:50 -0400
Received: from sonic306-2.consmr.mail.bf2.yahoo.com ([74.6.132.41]:44391 "EHLO
        sonic306-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbfIZOJu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 26 Sep 2019 10:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569506987; bh=euy9S2/4+kZy++A4IfrNsNY0nG5tpX3oraAf8XcNLZo=; h=Date:From:Reply-To:Subject:From:Subject; b=KTykoDhN2Qy/KCJeduJjiMcEwMwBk9NXKN7MTj8EKgvEKGh8M1AtWsgNb4MaWAp+bNs2zzi8I+FE9PBB5a3ZrLNp94jpcyWPMELqJVbGK0yz4u3SvGj2OWgJ71drFB04jUEfVlSPQI2ThOaM8wcKB6ljAO1ahaWoOgTU0VeVNxeeeLE4UQ7SxrHY7pQTuydPW6Rlpz321qzxrQ9qySIyxfzyvJhn64ah+lg3tYLtAGm15EGvsvZjhv7Lhy8TT53sNdRdbwdSox/b2Rz5zJmkC46I1W2juZl77b6u0USCg7cuTQRjVVKkVZLAf5s7Jx3CHyumDKS+HkzoL3ZXRkI2Uw==
X-YMail-OSG: _J5xAHQVM1mJ7927xJD2mv1iP1rGTkZ7YFMSTxM5FUBEqCGcRJZpI6JHGqeNLIn
 z384Q0wLQzINqfw78PMCkCA7DRFLsOYgHndW1UgpZfGMkyf8qR.3I_w8BKMiKUP2Pyyx.nPwKI_G
 23JJ_ZsOhkUWE5gSTkeUIydk.PQSUovzS_9DhQDrAxzOMSi1p1ehvd3dco1v7TUByTg2upQq_Hkn
 RZHibMXasibC_lQIO5bmB6QmcyBzHgWZ1i9GfyVfXUr89Rcj8r0.pgE_VF6rsnrCiFOpvKN0Lu3p
 m49gmYZ_1lOUvIHCCvJ6F0tHBhkEPMWuKkL2V43Oi.cLFbjKKHSRdWVPnSrRThISOFWK3C6q5yEH
 mLZCR8JcQIQsWJFU7zFfg.1dWT3sAPDrHtajL0F0AHVcF7iWrtmw6l64RAHya9kM28qfh5WjPtb0
 I5UJG0KK8g2bAmFdKqgM3Cxm3HA7hquQFmazjcaj_T9FDvHg9NzMfsBA1Anpzudtg1jSx9iW8BDN
 y.jzQxwaL2v5IPawxn.Z_inPDbIelIYu7B1rYIIKWqzNoGvKT5nf2dwP9QmJEPV_5.MN6rYF2Dhg
 zCH2V_nss.ncwD..pWVpx9EB_bTZBujh9scMUaqQHKguknZ_RtetsFkY8ldfN86YTJUUHvcPYMnh
 NeUTySoqqraIzzpR4zl3xGzlGjUY.y.JKbperZhfQM.c2Xdino8VnBlgYr0Jb.HqRm2lCTXeAuRm
 FtUOMiCRI5d82f9yTzBSEBAqNTg2Hc53zqu5IJ0RlkbFy8JbAIVN9Yr2jPuU6f8OAOjeV3VHgvZT
 jlXv4UOZESeHAmTfIvtl1n7Y6jfHUJvCtDDJBLkUvwlMAFzXb8FtGWyOAI8Q0fuVE8nrxgDD0ZL1
 D_sUy3BACG7ozQAjWUb7BRssxRmfEaI6vSdHckVcYT_0fh22zifT2UvAPDEwJfGp_4cHnxtd7ads
 JTwm3K4kgfto461AFi9WtOhZnQd1QclZmm5opwyoUH6KYl0tJHqVLDUVscAfmmYWIOuvL9FqyjGj
 6gEcgL1gRWVd_cTubu2DFZJTN.py6uepVklxkJrkAHTpw4H5lNsLByaY0ozeOX6Zt7fJMedrx5Lt
 3IJZ.P9OcFYVgnfx0Kv.dwXU.pR2C7TETha.LyAMWW4F_62fhx1PnbnvvsY1OnOi7R4UV8urV6UZ
 AHqFodGSIo_48WVrgH_z0smhNa2qkBUoDqg1APOktJOcRdUyJwouhVVjk6TqAEGth3t07G9i5u98
 KyHAZdESu77uenRsmdZrEOq8ieG98zvLKNjjfjEeKsQAYU71fIZYrYFvI5Q--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Thu, 26 Sep 2019 14:09:47 +0000
Date:   Thu, 26 Sep 2019 14:09:44 +0000 (UTC)
From:   "Mrs. Caroline Mark" <goshtholy7@gmail.com>
Reply-To: mrs.carolinemark@gmail.com
Message-ID: <1484771843.8940415.1569506984697@mail.yahoo.com>
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




