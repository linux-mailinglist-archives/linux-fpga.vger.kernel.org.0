Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7868B551
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Feb 2023 06:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBFFnq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Feb 2023 00:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFFnp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Feb 2023 00:43:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A813513;
        Sun,  5 Feb 2023 21:43:43 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b5so11020209plz.5;
        Sun, 05 Feb 2023 21:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJwN5lkElu+MAwjaAK326kHhi9oQbdV1CgXiKHMcd54=;
        b=pQ6++aKSoUmgqSJXZMKEGgl6upAyhVd+SkvW44ELn3xiKOFraC7i0DsZA1JOsDlR+L
         say+DLBWEp1SWlAfCVPuCGkwSeWSjdr+mOZkrjwbQPUkjltp1+Xen9FSFs6pZPfMovC8
         RyftxCPoK94bYmyAiWCgxF0iYjhBImc6r+yFwJAobi8xY6t90szElmrG8KQCHC7RSIzF
         SiWbuVRRMNnWzAyDqagW0VogWGa0DLxDgf62luYQ06GuZDMKbu/9i9kR1zjhFhGcdr/I
         sgwUQHejZhY68eg4CJhjhsbGlB2sIANjI3tSZfA7IUSdBYM7va4lVCukRaegejqQbdnT
         rrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJwN5lkElu+MAwjaAK326kHhi9oQbdV1CgXiKHMcd54=;
        b=C0P5SApbqPK04TJLTa+pCA/UtToLNjW78cIGeHJVczOLcnF0hCGp8B5i+mJQh0P9Y0
         ZVSzQvR71a0lPhX5sQI+w7+3GfFy7gdYe0ZdFknWl8wiYoEdwMJX5QFE+s44+GsJzNje
         ri4QEAQja/BjRIlQl8PQyhdb4mqiUaDTXL2KQin6ATmlLMtgJvBILJJIL+vXLdezJprW
         /Zy9DkWzx4mDq2jHbLVU4C58GBiw1n9+rXuWZ2YvfU9u0d9+UqmwmOe23AIx2LgzTxxj
         TFoq/8iDnp/PpF86lG+uhbeAv8asmoqHgT5XlmnbhkUDj0yDOzAxytaf0Pqn+mEPS26Q
         buKw==
X-Gm-Message-State: AO0yUKUGZ5qqe7RLVQA23d9czBo+pakPbtZMQJWfMI7n32oLEfDzHSMJ
        jwkiuD0pUlxtl8hV1PgOoik=
X-Google-Smtp-Source: AK7set9zS4to0TPCI7g3T4qwBRkgFpu++DCTMEnJsJ6xxyqMNNqRf5Tc3hNpfj3nWvFM6OQ4P+HYlQ==
X-Received: by 2002:a17:902:d481:b0:196:1a56:b1d3 with SMTP id c1-20020a170902d48100b001961a56b1d3mr21423349plg.11.1675662222710;
        Sun, 05 Feb 2023 21:43:42 -0800 (PST)
Received: from fuzzing.localdomain ([219.254.222.254])
        by smtp.gmail.com with ESMTPSA id s12-20020a170902b18c00b001949f21e1d2sm5777556plr.308.2023.02.05.21.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 21:43:42 -0800 (PST)
From:   k1rh4.lee@gmail.com
To:     Wu Hao <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sangsup Lee <k1rh4.lee@gmail.com>
Subject: [PATCH] fpga: dfl-afu-region: Add overflow checks for region size and offset
Date:   Sun,  5 Feb 2023 21:43:26 -0800
Message-Id: <20230206054326.89323-1-k1rh4.lee@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Sangsup Lee <k1rh4.lee@gmail.com>

The size + offset is able to be integer overflow value and it lead to mis-allocate region.

Signed-off-by: Sangsup Lee <k1rh4.lee@gmail.com>
---
 drivers/fpga/dfl-afu-region.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-region.c b/drivers/fpga/dfl-afu-region.c
index 2e7b41629406..82b530111601 100644
--- a/drivers/fpga/dfl-afu-region.c
+++ b/drivers/fpga/dfl-afu-region.c
@@ -151,12 +151,17 @@ int afu_mmio_region_get_by_offset(struct dfl_feature_platform_data *pdata,
 	struct dfl_afu_mmio_region *region;
 	struct dfl_afu *afu;
 	int ret = 0;
+	u64 region_size = 0;
 
 	mutex_lock(&pdata->lock);
+	if (check_add_overflow(offset, size, &region_size)) {
+		ret = -EINVAL;
+		goto exit;
+	}
 	afu = dfl_fpga_pdata_get_private(pdata);
 	for_each_region(region, afu)
 		if (region->offset <= offset &&
-		    region->offset + region->size >= offset + size) {
+		    region->offset + region->size >= region_size) {
 			*pregion = *region;
 			goto exit;
 		}
-- 
2.25.1

