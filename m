Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA90C2D62C0
	for <lists+linux-fpga@lfdr.de>; Thu, 10 Dec 2020 17:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391024AbgLJQ7L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Dec 2020 11:59:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46113 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbgLJQ7J (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 10 Dec 2020 11:59:09 -0500
Received: by mail-pl1-f195.google.com with SMTP id v3so3058891plz.13
        for <linux-fpga@vger.kernel.org>; Thu, 10 Dec 2020 08:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RjWYFS0t1qwCCykWF+LwjjyJCld4uAnADZtHP/eQeo=;
        b=CKwvGYNwc0tHKJKGJkRaOBjsKG3jpp4DhX+eKdXfbqC6M6N8D6ehJKfuLXWgt4Tvh7
         Y7W6crIvo8GGqwJH3RF1bQouAmXl9E/tBhxm1rj1MfDAwI9tqOw8P+C4Fua2/U5z71+i
         +1HqsJb1yR8tYUcGVxTbVvDDkgbbZ6EWicFMy+p9dUQpXlbx4VqWyWjkdLHlksXyToZY
         1jtjFNAyVOxpagOeoEsbD9fZrK6KL6sh1H2XNA9jwkAUpai6COVdfhNtu181HkMzG+1F
         hCWu0z/RGickf62AT4ZhXhFAtBHUce8pPO4ykIqCuLjaFtwwgivb1Z9Avgg68yBIrlkr
         9+Nw==
X-Gm-Message-State: AOAM530TEvMiJWW4bj2DMwRk+8uETA3hzoZtJOfm7gFvCkMNhWEgzRFj
        hmdWVB/2rUJUZzz+I8lnzu4=
X-Google-Smtp-Source: ABdhPJww3r/MMhIvblrkwmJMxMP5jc9E/FBTV0hiZXleYhZVSa8+7DDBJXvz7/5xB9hN2OMynfMiIg==
X-Received: by 2002:a17:902:a9c1:b029:da:8227:65f7 with SMTP id b1-20020a170902a9c1b02900da822765f7mr7216439plr.49.1607619508699;
        Thu, 10 Dec 2020 08:58:28 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id b20sm6235969pfi.218.2020.12.10.08.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:58:27 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com, hao.wu@intel.com,
        yilun.xu@intel.com, russell.h.weight@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 5/8] fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Date:   Thu, 10 Dec 2020 08:58:01 -0800
Message-Id: <20201210165804.44234-6-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210165804.44234-1-mdf@kernel.org>
References: <20201210165804.44234-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Xu Yilun <yilun.xu@intel.com>

Device Feature List (DFL) is a linked list of feature headers within the
device MMIO space. It is used by FPGA to enumerate multiple sub features
within it. Each feature can be uniquely identified by DFL type and
feature id, which can be read out from feature headers.

A dfl bus helps DFL framework modularize DFL device drivers for
different sub features. The dfl bus matches its devices and drivers by
DFL type and feature id.

This patch adds dfl bus support to MODULE_DEVICE_TABLE() by adding info
about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
point in file2alias.c.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Wu Hao <hao.wu@intel.com>
---
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 27007c18e754..d8350eea6d1a 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -243,5 +243,9 @@ int main(void)
 	DEVID(mhi_device_id);
 	DEVID_FIELD(mhi_device_id, chan);
 
+	DEVID(dfl_device_id);
+	DEVID_FIELD(dfl_device_id, type);
+	DEVID_FIELD(dfl_device_id, feature_id);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2417dd1dee33..8a438c94dcd9 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1368,6 +1368,18 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: dfl:tNfN */
+static int do_dfl_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, dfl_device_id, type);
+	DEF_FIELD(symval, dfl_device_id, feature_id);
+
+	sprintf(alias, "dfl:t%04Xf%04X", type, feature_id);
+
+	add_wildcard(alias);
+	return 1;
+}
+
 /* Does namelen bytes of name exactly match the symbol? */
 static bool sym_is(const char *name, unsigned namelen, const char *symbol)
 {
@@ -1442,6 +1454,7 @@ static const struct devtable devtable[] = {
 	{"tee", SIZE_tee_client_device_id, do_tee_entry},
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
+	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.29.2

