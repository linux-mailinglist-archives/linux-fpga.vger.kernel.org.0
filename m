Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BB12EC96F
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 05:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbhAGEjK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jan 2021 23:39:10 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:44183 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbhAGEjJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jan 2021 23:39:09 -0500
Received: by mail-pl1-f171.google.com with SMTP id r4so2838432pls.11;
        Wed, 06 Jan 2021 20:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bsody02pBKJ1Kl2CryWLxJY47LlftTk/tF41qxFvkmo=;
        b=ENyeMmvBSnSpjRGLfexTdxGt7j4u5eFdy9mbYL1GELUD4QNT4fK5mqro2OqmStXisX
         DvR5thioL5eal6FXazDv+K2ck/NhVE7pQ1x4p0vXtyaaCwiJoM2pOFzLYqc3oHFyDW+1
         KjwWAYorEBKiwPuq0y5Hw2VOm6v8f37SJ6UF942wYPaOq6lcMDRHrIzmu8brgdak/JLp
         6BxUei2NjnfuEw6fVbgkGgQG8J1JwqF6BehSWvAFhtKcPPO7sobILlg3hI38JVd0h3e6
         8hcpBDGTTfzcEUVKiDJvlKimRNbqA5xAt3fhALuXGpWu/SNsd+ImDMO06iqtZxvvq4F3
         o3uw==
X-Gm-Message-State: AOAM5315JLHRkANi7eeJyvbVvrgaBaduLZss1b4GviCNfXMD0qrGtgW1
        Spwfs+9q5x1af1SFEJ+oLyE=
X-Google-Smtp-Source: ABdhPJzVjVA4ELUxpABcACKfsmOEubfnwiKqyqPwiVSep4Pa9ooAV2RTXXnhrjnUNmKRkZ09TYG/VA==
X-Received: by 2002:a17:90a:9d88:: with SMTP id k8mr7556753pjp.141.1609994309042;
        Wed, 06 Jan 2021 20:38:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id n195sm3967949pfd.169.2021.01.06.20.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 20:38:28 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 5/8] fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Date:   Wed,  6 Jan 2021 20:37:11 -0800
Message-Id: <20210107043714.991646-6-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107043714.991646-1-mdf@kernel.org>
References: <20210107043714.991646-1-mdf@kernel.org>
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
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index e377f52dbfa3..1b14f3cde4e5 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -246,5 +246,9 @@ int main(void)
 	DEVID(auxiliary_device_id);
 	DEVID_FIELD(auxiliary_device_id, name);
 
+	DEVID(dfl_device_id);
+	DEVID_FIELD(dfl_device_id, type);
+	DEVID_FIELD(dfl_device_id, feature_id);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index fb4827027536..7ebabeb1e9c9 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1375,6 +1375,18 @@ static int do_auxiliary_entry(const char *filename, void *symval, char *alias)
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
@@ -1450,6 +1462,7 @@ static const struct devtable devtable[] = {
 	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
 	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
 	{"auxiliary", SIZE_auxiliary_device_id, do_auxiliary_entry},
+	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.30.0

