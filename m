Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9E054C77A
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Jun 2022 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbiFOLY4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Jun 2022 07:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343678AbiFOLYy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 15 Jun 2022 07:24:54 -0400
Received: from mail.pr-group.ru (mail.pr-group.ru [178.18.215.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234BC35A8A;
        Wed, 15 Jun 2022 04:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=metrotek.ru; s=mail;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:
         in-reply-to:references;
        bh=EcbvH5RPee/rDXWiMNRyyIbGRAOxhEMvSxY8cLtRaOA=;
        b=JTrJbypxiCe4DA5b8ilhmOAS03uiZCbk6o15Fc8yatSx98SQtP/dwOXMT5iq/lpO1ZrvKWZCrTXz4
         fFzkTYUIWsDSu9DTvyQ1m+hmisN6RrFOxIXm8hc+42PXxfJL/o1FYZsK9KFFckBCfIW6CZl6s+/tEY
         1OTf9STlgXuLyD030MsdDp3Jxunn7q6Y6fSOa1/+8zxwv6AWkzUGd3ejk4d/Opmq5rhdRoWro2mbDM
         Q9Gf2D6i2hoFrU2Dl9GRccvEw8pZcIbEeuQ6AvzFH7p5AiRgALJFdoOWthg6hMTwnA4/qRlDtsgRQo
         OZ1lexoWE0rxhEUD1fchpylSA13sUhA==
X-Kerio-Anti-Spam:  Build: [Engines: 2.16.3.1424, Stamp: 3], Multi: [Enabled, t: (0.000014,0.011691)], BW: [Enabled, t: (0.000026,0.000001)], RTDA: [Enabled, t: (0.080385), Hit: No, Details: v2.40.0; Id: 15.52kcj6.1g5jhna0l.32ps; mclb], total: 0(700)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Footer: bWV0cm90ZWsucnU=
Received: from localhost.localdomain ([85.143.252.66])
        (authenticated user i.bornyakov@metrotek.ru)
        by mail.pr-group.ru with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Wed, 15 Jun 2022 14:24:32 +0300
From:   Ivan Bornyakov <i.bornyakov@metrotek.ru>
To:     mdf@kernel.org, hao.wu@intel.com, yilun.xu@intel.com,
        trix@redhat.com, corbet@lwn.net
Cc:     Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru
Subject: [PATCH v19 2/4] docs: fpga: mgr: document parse_header() callback
Date:   Wed, 15 Jun 2022 14:01:35 +0300
Message-Id: <20220615110137.21902-3-i.bornyakov@metrotek.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615110137.21902-1-i.bornyakov@metrotek.ru>
References: <20220615110137.21902-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Document newly introduced fpga_manager_ops callback parse_header() along
with header_size and data_size fields of struct fpga_image_info.

Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
---
 Documentation/driver-api/fpga/fpga-mgr.rst | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 42c01f396dce..f1e106c3194c 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -79,14 +79,29 @@ do the programming sequence for this particular FPGA.  These ops return 0 for
 success or negative error codes otherwise.
 
 The programming sequence is::
- 1. .write_init
- 2. .write or .write_sg (may be called once or multiple times)
- 3. .write_complete
-
-The .write_init function will prepare the FPGA to receive the image data.  The
-buffer passed into .write_init will be at most .initial_header_size bytes long;
-if the whole bitstream is not immediately available then the core code will
-buffer up at least this much before starting.
+ 1. .parse_header (optional, may be called once or multiple times)
+ 2. .write_init
+ 3. .write or .write_sg (may be called once or multiple times)
+ 4. .write_complete
+
+The .parse_header function will set header_size and data_size to
+struct fpga_image_info. If header_size is set, .write function will get image
+buffer starting at header_size offset from the beginning. If data_size is set,
+.write function will get data_size bytes of the image buffer, otherwise .write
+will get data up to the end of image buffer. This will not affect .write_sg,
+.write_sg will still get whole image in sg_table form. If FPGA image is
+already mapped as a single contiguous buffer, whole buffer will be passed into
+.parse_header. If image is in scatter-gather form, core code will buffer up at
+least .initial_header_size before the first call of .parse_header, if it is
+not enough, .parse_header should set desired size into info->header_size and
+return -EAGAIN, then it will be called again with greater part of image buffer
+on the input.
+
+The .write_init function will prepare the FPGA to receive the image data. The
+buffer passed into .write_init will be at least info->header_size bytes long,
+if it's defined, otherwise .initial_header_size; if the whole bitstream is not
+immediately available then the core code will buffer up at least this much
+before starting.
 
 The .write function writes a buffer to the FPGA. The buffer may be contain the
 whole FPGA image or may be a smaller chunk of an FPGA image.  In the latter
-- 
2.35.1


