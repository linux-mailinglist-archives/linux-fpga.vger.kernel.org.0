Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06AE72A3D7A
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgKCHVX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:21:23 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46568 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCHVX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:21:23 -0500
Received: by mail-pf1-f193.google.com with SMTP id y14so13390661pfp.13
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/l5+sH9ZV3KVY9dL9+dpfycY1OwjtZ+7+ED7dKIYk/A=;
        b=tXKvV/nUlvE2984H5kbrXotdokZmgwboe53Qomh6N/KVVc7xsOhLX5N9n/k1dmSlDS
         GwRXZDoSBGyrAjrf1vqjOXr4Gqcmj85HTP008FbmDebutW6lMHZDDSjL/iAEbFJHGbMs
         1rW+3vWydeTPALzu1fS5bLTkf0AFtHOBBZedu81riNe5nlf0FPefS0TVgNaUNggGJ+Hx
         MYXQ1G8t8h+/UpEBf3eFgjnIg4ZZKMjyLKAfJCnPpsSP3ou3JK1NMZKAF9ZdPYZSk+w5
         g01fr0vw1O2ar2zyUr3Ld4mDSmNlQBAtYget5+TPNKewSMuJzzCq6m0rsZWyZgNObvDH
         rBvg==
X-Gm-Message-State: AOAM532UQS+3R9zUFMKIavPyG5f1eBN/CRebe5+Wv49KkzFvnZoIBas6
        UIbNEfVvJA1a7J3sI8ZxJon5XN2/E4o=
X-Google-Smtp-Source: ABdhPJz3dhtVOVNibbUyxxosjfqjKln57WrQPg+HMEX4I2vlIC6BlgytE7542a7DY68qVsk0TJ5jfg==
X-Received: by 2002:a62:f846:0:b029:15f:f897:7647 with SMTP id c6-20020a62f8460000b029015ff8977647mr24631885pfm.75.1604388082448;
        Mon, 02 Nov 2020 23:21:22 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y141sm15755634pfb.17.2020.11.02.23.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:21:22 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 3/4] fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Date:   Mon,  2 Nov 2020 23:21:03 -0800
Message-Id: <20201103072104.12361-4-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103072104.12361-1-mdf@kernel.org>
References: <20201103072104.12361-1-mdf@kernel.org>
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

