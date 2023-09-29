Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9237B36A1
	for <lists+linux-fpga@lfdr.de>; Fri, 29 Sep 2023 17:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbjI2PWE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 29 Sep 2023 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233537AbjI2PWD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 29 Sep 2023 11:22:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19331193
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0DUH2bfyE6C8uTlVJHwvrkC7QPYIHAMcvQVh1UrVCss=;
        b=JxQGKg6vjIeJGB55T2GQRB1uB0pBhwS/ecFS1ZDrcr4w9QIGzmYqXY1dzFFWS6CEHYcuDp
        dk/JcSFTyo0F899xl6BV2PNqTI3pvfTbWsJJI4yg9cjgKuwZ8f/xChsOqc41/spM8pw9dc
        nGKOEJ/Rm8Nflg/ewO03NiDoI4AQ0hg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-v5MivpcaOrGMmC33-X7d4Q-1; Fri, 29 Sep 2023 11:21:18 -0400
X-MC-Unique: v5MivpcaOrGMmC33-X7d4Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-418099ca1c2so188316941cf.0
        for <linux-fpga@vger.kernel.org>; Fri, 29 Sep 2023 08:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000878; x=1696605678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DUH2bfyE6C8uTlVJHwvrkC7QPYIHAMcvQVh1UrVCss=;
        b=xQ7P5VNhx9t+35s8XOWYFMbXyybn+vaQMvaNG1v+4YbHHUONkEBuvr3PeGVrCHsf+y
         Bc09JBGjJRQKjhF/kitXR3AOvIpEaVOZryjjMkKbFvgBPtMy75SHG45g5VtRBs05grgh
         QonYcw+pmx+Fa0WPw4hlBrMFMy7rUyO1rG933/7wYIOnn+xeQMqEF7e2h/YVYLzBuRF1
         q2LarRKUQjWeLzTUQ8VuEVt53uQSMzau1DxdKLteiIrsbKJnlOZau6xl3a/wrN6xSJvm
         L1z+OONNAmZHvJnSdY/seCLicxYQoDvTBFWn3Jl0rXelxZwr42HuqpXa4myPPUbvFdxY
         cjGg==
X-Gm-Message-State: AOJu0Yw0eoxmnPkTKTqzIroBd0QWIBkyfwuiPsMvjy+2BWFwRnwwXWGQ
        SVHO2MBTbhPnQxJTD0o76mJbEONfOsAxEC0Pw3QrHubLEdHVjbMaLlQXGoICENCmO1dRoA10eWI
        ZRTFgufr2WBrU40lnvgMRVYMXtbb2
X-Received: by 2002:a05:622a:118e:b0:418:11ab:1c00 with SMTP id m14-20020a05622a118e00b0041811ab1c00mr5502850qtk.49.1696000878155;
        Fri, 29 Sep 2023 08:21:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZlhCTSd6qQ+sjvWEHY9Ok3klVHcIN817mjhPcqv1+65iA9JVgEHlreisFjo/ADJxKpJMnEg==
X-Received: by 2002:a05:622a:118e:b0:418:11ab:1c00 with SMTP id m14-20020a05622a118e00b0041811ab1c00mr5502823qtk.49.1696000877846;
        Fri, 29 Sep 2023 08:21:17 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:17 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v2 1/4] fpga: add helpers for the FPGA KUnit test suites.
Date:   Fri, 29 Sep 2023 17:20:54 +0200
Message-ID: <20230929152057.85047-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929152057.85047-1-marpagan@redhat.com>
References: <20230929152057.85047-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add helpers to facilitate the registration of minimal platform drivers
to support parent platform devices used for testing.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h

diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
new file mode 100644
index 000000000000..6a28ed30bf71
--- /dev/null
+++ b/drivers/fpga/tests/fpga-test-helpers.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KUnit test for the FPGA Manager
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#ifndef _FPGA_KUNIT_HELPERS_H
+#define _FPGA_KUNIT_HELPERS_H
+
+#define TEST_PDEV_NAME	"fpga-test-pdev"
+
+#define TEST_PLATFORM_DRIVER(__drv_name)			\
+	__TEST_PLATFORM_DRIVER(__drv_name, TEST_PDEV_NAME)
+/*
+ * Helper macro for defining a minimal platform driver that can
+ * be registered to support the parent platform devices used for
+ * testing.
+ */
+#define __TEST_PLATFORM_DRIVER(__drv_name, __dev_name)		\
+static struct platform_driver __drv_name = {			\
+	.driver = {						\
+		.name = __dev_name,				\
+	},							\
+}
+
+#endif	/* _FPGA_KUNIT_HELPERS_H */
-- 
2.41.0

