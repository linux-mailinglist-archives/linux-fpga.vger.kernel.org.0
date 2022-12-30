Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACF96596CF
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Dec 2022 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiL3JcT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Dec 2022 04:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbiL3JcR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Dec 2022 04:32:17 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741031A39E;
        Fri, 30 Dec 2022 01:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding;
        bh=tuVGBpd31T4yKCAmXPLRKEmib/9bOaSApKK+OXLQB6A=;
        b=TeM/AY+A6WKr9pnzGR9xuqghLQygitIcOH9bDA5Uuu5gN+bslNxMBZhjXeh2d8CbRLVpEQ7Bs57ER
         7eFkUyKcf7yl/ISsRj7++4bh4Sefidjj/NdY65JYPb0aSRZ8k/JU1lMTxM+0HAKA5ivcSHRkK/HZxh
         piLkZVeogDo8MBIv08BspFO+thNWaFR4dpMbpUILr0y2m18hymVODg58dTjKLy2HbNKV6KTlAOsvMd
         3IBg47egu3yIwrxtIEHCZr02KPHI1I7MMd91NfxwinwcqWaFEpWlLJ4xbNkcy7cy137gWVcWNuYLdt
         orowRd4wZvuwVdz/oE9G1MWGMfYakGQ==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000016,0.007889)], BW: [Enabled, t: (0.000024,0.000001)], RTDA: [Enabled, t: (0.084933), Hit: No, Details: v2.42.0; Id: 15.52k4og.1glh5v6ls.1si; mclb], total: 0(700)
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLACK autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 30 Dec 2022 12:31:49 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     linux-fpga@vger.kernel.org
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v5 0/3] Reliability improvements for Microchip MPF FPGA manager
Date:   Fri, 30 Dec 2022 12:29:19 +0300
Message-Id: <20221230092922.18822-1-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.38.2
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
[https://lore.kernel.org/linux-fpga/20221229104604.2496-1-i.bornyakov@metrotek.ru/]
  v5:
    * revord "fpga: microchip-spi: move SPI I/O buffers out of stack"
      commit message "Use allocated buffers" -> "Use cacheline aligned
      buffers"
    * drop __aligned(ARCH_KMALLOC_MINALIGN) attribute of struct mpf_priv
      member "rx". tx and rx are used synchronously by dma, they could
      share a cacheline.

Ivan Bornyakov (3):
  fpga: microchip-spi: move SPI I/O buffers out of stack
  fpga: microchip-spi: rewrite status polling in a time measurable way
  fpga: microchip-spi: separate data frame write routine

 drivers/fpga/microchip-spi.c | 145 +++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 66 deletions(-)

-- 
2.38.2


