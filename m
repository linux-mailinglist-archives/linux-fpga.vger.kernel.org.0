Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9AB68D319
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 10:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjBGJk7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 04:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjBGJk6 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 04:40:58 -0500
X-Greylist: delayed 892 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 01:40:57 PST
Received: from mail.crawnon.pl (mail.crawnon.pl [51.68.198.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AB4ECA
        for <linux-fpga@vger.kernel.org>; Tue,  7 Feb 2023 01:40:56 -0800 (PST)
Received: by mail.crawnon.pl (Postfix, from userid 1002)
        id 4C5D2A2C16; Tue,  7 Feb 2023 09:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crawnon.pl; s=mail;
        t=1675761371; bh=C5hX24svv/9/TME4wPCHfYjl17BCtmuxEd1i9B4zdYs=;
        h=Date:From:To:Subject:From;
        b=PsTnLwEvbeUHyeLDQGEH/IG70/mYhdMfN7pIL/wdM7FpX7AsfZMkjkdmN4pcd4D93
         Yop+aZGDsMKQsAIhwPLnWBGr9MnTvJa9D8sfnSm1414Ns9AAbDf5ovo8QVXgMYac4S
         cDuT/GbTU0WXbA+qIHNpCBshqeS1YDLvGfLXErSRG30j5GBWYexmlOKPbpFKNADxRA
         4drWuAMtbAz75YBirZ5SSo0Et+lN6gdf4vp8REaSJl/5ns2HSw9r5Ambrrg15L3yfj
         R2s6Nq8Qb5DniJ9eSurSWQhB/kwQHWrpJxAfUF+TeoGs0o49e2TUYjFXZ7bnOfJbEL
         0vGMi9ev+NCWw==
Received: by mail.crawnon.pl for <linux-fpga@vger.kernel.org>; Tue,  7 Feb 2023 09:15:23 GMT
Message-ID: <20230207074500-0.1.90.hw48.0.iayktcup15@crawnon.pl>
Date:   Tue,  7 Feb 2023 09:15:23 GMT
From:   =?UTF-8?Q? "Miko=C5=82aj_Fiodorczyk" ?= 
        <mikolaj.fiodorczyk@crawnon.pl>
To:     <linux-fpga@vger.kernel.org>
Subject: Fotowoltaika - nowe warunki
X-Mailer: mail.crawnon.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,URIBL_CSS_A,
        URIBL_DBL_SPAM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: crawnon.pl]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [51.68.198.42 listed in zen.spamhaus.org]
        *  0.1 URIBL_CSS_A Contains URL's A record listed in the Spamhaus CSS
        *      blocklist
        *      [URIs: crawnon.pl]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [51.68.198.42 listed in bl.score.senderscore.com]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0201]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Dzie=C5=84 dobry,

chcia=C5=82bym poinformowa=C4=87, i=C5=BC mog=C4=85 Pa=C5=84stwo uzyska=C4=
=87 dofinansowanie na systemy fotowoltaiczne w ramach nowej edycji progra=
mu M=C3=B3j Pr=C4=85d.

Program zapewnia 6000 z=C5=82 dofinansowania na instalacj=C4=99 paneli i =
16 000 z=C5=82 na magazyn energii, ni=C5=BCsze cen pr=C4=85du i mo=C5=BCl=
iwo=C5=9B=C4=87 odliczenia koszt=C3=B3w zwi=C4=85zanych z instalacj=C4=85=
 fotowoltaiki w ramach rozliczenia PIT (tzw. ulga termomodernizacyjna).

Czy s=C4=85 Pa=C5=84stwo otwarci na wst=C4=99pn=C4=85 rozmow=C4=99 w tym =
temacie?


Pozdrawiam,
Miko=C5=82aj Fiodorczyk
