Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A0B7AF0F1
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Sep 2023 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjIZQkP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Sep 2023 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjIZQkM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Sep 2023 12:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D85136
        for <linux-fpga@vger.kernel.org>; Tue, 26 Sep 2023 09:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=av4Q5tr0bnozwSJldJa/tKMZzYdZGmoPuhbGkeCDqlg=;
        b=WJfGaTgtzJKWMm0mGKlLq5KOsU41kWvfDHxakXauvgQKcw3xYpueIcVv1n7AFTjGjk79sB
        0JVcOhgSsO3R5yUgkiMmDcrN90b9CIwzeDtK0Vk5byRuuWfYrre6STi+cu5sDPU3qzMtN4
        cLNWOwousvZtZ/5ni4QhAZOQMvYJRsU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-B8JoD4OVOAyZIryDpv1TDg-1; Tue, 26 Sep 2023 12:39:23 -0400
X-MC-Unique: B8JoD4OVOAyZIryDpv1TDg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31fd48da316so7252452f8f.3
        for <linux-fpga@vger.kernel.org>; Tue, 26 Sep 2023 09:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746362; x=1696351162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av4Q5tr0bnozwSJldJa/tKMZzYdZGmoPuhbGkeCDqlg=;
        b=pxnJKOqGYoVGK+ODFRBM2d/FB0rnV5HQcoyDo7+C5+iqrukj6fN6G/2ejXRDIMGFwl
         Fe6DHvi5INP3SUYZE0703q2JoGpCbE5h+EKkOv0j9hJroE2p4j6PoFqXkW91Whm+62/0
         gf4jZcmhiRRs5LFAN3rC5yjbyARfhKv2IPKCgQnf6jW+Kb/S12lJotkdP1iX6AzaOppF
         W9ct0YQbXali6QluiLQsJG1UJDrfBTfHk1Z6otFcIiopyV4GpnIFUEckwt5T0cKvefIJ
         7Qnami1wYg45vPZmof9fkNqbwvTIqoi3E2OsdlnWTe7OtXxauw8EfbpctZtG4Y7Lt4MR
         87PQ==
X-Gm-Message-State: AOJu0YyZ70riC09awNJQp62L9IXTGrUcu3MOf7/3JH7F96uvBNw0jZYk
        UdALRgWZPthA3xlW7/F46paMgXhwRI8CCgECM/AHAjgjQNE7H5SVLeKdWjFpJDvCF5OlNNH4+OI
        UmQLPYWnE7N9HoTl87coCWPTJeI2h
X-Received: by 2002:adf:f891:0:b0:320:66:cf67 with SMTP id u17-20020adff891000000b003200066cf67mr8551639wrp.18.1695746362269;
        Tue, 26 Sep 2023 09:39:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ila2SCVWp13EofwUd5ovY7r6En2sCXu1+29pWKRQjRuQNyl9s1EJv237ExyfKfZoffbgNA==
X-Received: by 2002:adf:f891:0:b0:320:66:cf67 with SMTP id u17-20020adff891000000b003200066cf67mr8551628wrp.18.1695746362039;
        Tue, 26 Sep 2023 09:39:22 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:21 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH 1/4] fpga: add helpers for the FPGA KUnit test suites.
Date:   Tue, 26 Sep 2023 18:39:08 +0200
Message-ID: <20230926163911.66114-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926163911.66114-1-marpagan@redhat.com>
References: <20230926163911.66114-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add helpers to facilitate the registration of minimal platform drivers
to support the parent platform devices used for testing.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-test-helpers.h | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-test-helpers.h

diff --git a/drivers/fpga/tests/fpga-test-helpers.h b/drivers/fpga/tests/fpga-test-helpers.h
new file mode 100644
index 000000000000..fcad3249be68
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
+#ifndef FPGA_KUNIT_HELPERS_
+#define FPGA_KUNIT_HELPERS_
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
+#endif	/* FPGA_KUNIT_HELPERS_ */
-- 
2.41.0

