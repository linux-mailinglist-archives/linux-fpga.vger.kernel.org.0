Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E70656950
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Dec 2022 11:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiL0KHb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Dec 2022 05:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiL0KHa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Dec 2022 05:07:30 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9ED6477;
        Tue, 27 Dec 2022 02:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=9VAb8lkRkUO1oko3y3yvtQIrdTIKswb5JUMuGaTrGbM=;
        b=m0TuOWcTlHJ5yC3nSG/vz3Bdzh2PJQXUOvePloBUn8vc05THbgy2hgLZfUNnz0VPRiF8fXovzSEoy
         EjQULhDIbcGUO6cSWVqNH9NJUVMtAQWYGuDtgkRdCemey8HL1gx0j82yHbqTHN2tIryYd1Ai+TQfFG
         Sq+VAVTTijOExenei3KIdC/3U9dYKLCi+zAZ7Qr8FwYzRE2zJ8wyeE9riFTdyMbxlhEDSmujyBAcW8
         JodGp6L+aXQLisMUKWzK0Ee1KaYHc3SQxi+mhllwWZoWdRJoFysaffyab0UAtAC8mEqCL7UOCHkJ3h
         PKUdRZ6WwAVXjxofNgHkbxbuKJbv4Og==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000013,0.010743)], BW: [Enabled, t: (0.000025,0.000002)], RTDA: [Enabled, t: (0.088120), Hit: No, Details: v2.42.0; Id: 15.52kc2o.1gl9gpneu.3rr; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Tue, 27 Dec 2022 13:07:08 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v3 0/3] Reliability improvements for Microchip MPF FPGA manager
Date:   Tue, 27 Dec 2022 13:04:47 +0300
Message-Id: <20221227100450.2257-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
MIME-Version: 1.0
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

Ivan Bornyakov (3):
  fpga: microchip-spi: move SPI I/O buffers out of stack
  fpga: microchip-spi: rewrite status polling in a time measurable way
  fpga: microchip-spi: separate data frame write routine

 drivers/fpga/microchip-spi.c | 137 ++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 65 deletions(-)

-- 
2.38.2


