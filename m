Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109E658BF7
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Dec 2022 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiL2KtX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Dec 2022 05:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiL2KtL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Dec 2022 05:49:11 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D028912AD1;
        Thu, 29 Dec 2022 02:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding;
        bh=k7gYzabHTTDOgCUDLMX/MCE9I6z53Uh/Rqs9+rbTYgw=;
        b=Kd4kxdR1DBRC3NGS3lN/pJ0MghskClEHZ/wqg0SEQwH9Ian9HiJXgUGyCTWmbTzWvSRK21OHalW4p
         DWFMOKazoEj5yC2o7Av3S001/eXUI75L/hon3NtnNfFfzKG7WYV38QUfg51O4W1CjAPeGQe+1F3cR5
         Pi5SEZQa1dDkvGNjMAESVCm3Z/jwG21119cYnb0d/6RtD34se3JG0P2WVrPDo/2p6yMtt54WgV1fot
         UgbfG/sJLUtFV+MfEcMYraQawkInW8mqObW1gf5+cRGVyl8Iplf72wRCgYvf2untBPl4bpFWRZc0fx
         qEBnFAl9tC95Y62LXNhCLp2Lhmj4lMA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000008,0.006695)], BW: [Enabled, t: (0.000016,0.000001)], RTDA: [Enabled, t: (0.091441), Hit: No, Details: v2.42.0; Id: 15.52k8sc.1glenv90a.id64; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Thu, 29 Dec 2022 13:48:42 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v4 0/3]  Reliability improvements for Microchip MPF FPGA manager
Date:   Thu, 29 Dec 2022 13:46:01 +0300
Message-Id: <20221229104604.2496-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

A couple of reliability improvements for Microchip Polarfire FPGA
manager:
 * move SPI I/O buffers out of stack
 * rewrite status polling routine in a time measurable way

Also improve mpf_ops_write() code readability by separating single data
frame writing routine.

ChangeLog:
  v1:
[https://lore.kernel.org/linux-fpga/20221223123854.8023-1-i.bornyakov@metrotek.ru/]
  v2:
    * split into 3 distinct patches
[https://lore.kernel.org/linux-fpga/20221226142326.8111-1-i.bornyakov@metrotek.ru/]
  v3:
    * fix polling stop condition in mpf_poll_status() as Ilpo suggested.
[https://lore.kernel.org/linux-fpga/20221227100450.2257-1-i.bornyakov@metrotek.ru/]
  v4:
    * more verbose comment for mpf_poll_status()

Ivan Bornyakov (3):
  fpga: microchip-spi: move SPI I/O buffers out of stack
  fpga: microchip-spi: rewrite status polling in a time measurable way
  fpga: microchip-spi: separate data frame write routine

 drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 66 deletions(-)

-- 
2.39.0


