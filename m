Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C9656378
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Dec 2022 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiLZOhI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 26 Dec 2022 09:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiLZO3K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 26 Dec 2022 09:29:10 -0500
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7C464EA;
        Mon, 26 Dec 2022 06:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=rxYaNlTu1sVG3D7zPXhKMJeE1kMst4HG0mdqpjHL0Ig=;
        b=dEGP2qcLdJWfRJWDi6J+pPJjcqcCtx9JKXG1ryTG+VK5FB4/TxbA4l59PK8k+hNJNzYX/Fa1sCCm2
         b+Ye1NgLDruzIRcDOOk1O4ky2YSoBn7oduzkfKE1JMyMG0mrC3N59z2IjdYiCOGQpq6P+QewQXa0nP
         aX5VcR36UB2XkrPcUal2YykMsJrlsS7dv91BjeDN9ydBcfaTVP2hs2qzP9v+7E3QCUd3Q1DdqhmbRi
         S2Ct4LtNN77FHY7qstHOQPqTOtvrh0B/jJiu1uPTG9gRYQ5iAfVRu+EizkjNY6YUIDYVkBw/OKNsN/
         8eYNu2OeyULQeRqEWs8csNm6A7HgUTw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.5.1460, Stamp: 3], Multi: [Enabled, t: (0.000013,0.009504)], BW: [Enabled, t: (0.000024,0.000002)], RTDA: [Enabled, t: (0.083402), Hit: No, Details: v2.42.0; Id: 15.52k1a7.1gl7d6qee.1g; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([78.37.162.181])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Mon, 26 Dec 2022 17:25:55 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: [PATCH v2 0/3] Reliability improvements for Microchip MPF FPGA manager
Date:   Mon, 26 Dec 2022 17:23:23 +0300
Message-Id: <20221226142326.8111-1-i.bornyakov@metrotek.ru>
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

Ivan Bornyakov (3):
  fpga: microchip-spi: move SPI I/O buffers out of stack
  fpga: microchip-spi: rewrite status polling in a time measurable way
  fpga: microchip-spi: separate data frame write routine

 drivers/fpga/microchip-spi.c | 138 ++++++++++++++++++-----------------
 1 file changed, 73 insertions(+), 65 deletions(-)

-- 
2.38.2


