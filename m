Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172F954F8A1
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jun 2022 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382414AbiFQNt5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jun 2022 09:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiFQNty (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Jun 2022 09:49:54 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E08A43385;
        Fri, 17 Jun 2022 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=Hz1N3iQRQ8cqLzLkwSQu0ZphBJbofHB1qe/OnX978VY=;
        b=Ja/Ge57E11DS2Kd/3ofi/C33E0VW510gHg7EBJxHOi7aq2EnYo+XRisuYPcvcVv8teiBy0yf+KgcI
         a0AVmM3QhbwdgZv5bXz1vX7Syf4+G1KdJxmXkCwcZ37KOuyQqUBTVNjXuql9v7PkSlBCoqWs3aA3dt
         WsRs2OzEFKG4UOD7A7MhgFbyI8MoZyg2LxUe+xL/doT8AhdijdmkaeEn7d+jLUvYsQnYT1tSgkSsTC
         8YMK2GWQrq4CdZhh979Gg256zDXOdSeMQMcS1clyXY/1yje+1vuWqL4FLcA2cypZ/jb+80zZH1L9T5
         B86NYHQFGgUDjlYKh/L0v1QxscqPcJw==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000010,0.010967)], BW: [Enabled, t: (0.000015,0.000001)], RTDA: [Enabled, t: (0.076789), Hit: No, Details: v2.40.0; Id: 15.52k5n9.1g5oupv3g.28mf; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from h-e2.ddg ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 17 Jun 2022 16:49:22 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v20 2/4] docs: fpga: mgr: document parse_header() callback
Date:   Fri, 17 Jun 2022 16:48:44 +0300
Message-Id: <20220617134846.19859-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617134846.19859-1-i.bornyakov@metrotek.ru>
References: <20220617134846.19859-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Document newly introduced fpga_manager_ops callback parse_header() and
flag skip_header along with header_size and data_size fields of struct
fpga_image_info.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 27 +++++++++++++++++-----
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 42c01f396dce..49c0a9512653 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -79,12 +79,27 @@ do the programming sequence for this particular FPGA.  These ops return 0 for
 success or negative error codes otherwise.
 
 The programming sequence is::
- 1. .write_init
- 2. .write or .write_sg (may be called once or multiple times)
- 3. .write_complete
-
-The .write_init function will prepare the FPGA to receive the image data.  The
-buffer passed into .write_init will be at most .initial_header_size bytes long;
+ 1. .parse_header (optional, may be called once or multiple times)
+ 2. .write_init
+ 3. .write or .write_sg (may be called once or multiple times)
+ 4. .write_complete
+
+The .parse_header function will set header_size and data_size to
+struct fpga_image_info. Before parse_header call, header_size is initialized
+with initial_header_size. If flag skip_header of fpga_manager_ops is true,
+.write function will get image buffer starting at header_size offset from the
+beginning. If data_size is set, .write function will get data_size bytes of
+the image buffer, otherwise .write will get data up to the end of image buffer.
+This will not affect .write_sg, .write_sg will still get whole image in
+sg_table form. If FPGA image is already mapped as a single contiguous buffer,
+whole buffer will be passed into .parse_header. If image is in scatter-gather
+form, core code will buffer up at least .initial_header_size before the first
+call of .parse_header, if it is not enough, .parse_header should set desired
+size into info->header_size and return -EAGAIN, then it will be called again
+with greater part of image buffer on the input.
+
+The .write_init function will prepare the FPGA to receive the image data. The
+buffer passed into .write_init will be at least info->header_size bytes long;
 if the whole bitstream is not immediately available then the core code will
 buffer up at least this much before starting.
 
-- 
2.25.1


