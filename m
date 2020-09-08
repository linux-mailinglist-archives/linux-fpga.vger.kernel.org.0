Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4A260A5F
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Sep 2020 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728805AbgIHFxW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Sep 2020 01:53:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:17184 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIHFxS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 8 Sep 2020 01:53:18 -0400
IronPort-SDR: 2XaLk+mjWZ5DuS87C2q0lQe53uKoo/zzOZ1OCyk0euURV2NJy5tgabicYsaNc3QUHWW01XJTMt
 tXelngwqPyqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="138124886"
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="138124886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 22:53:18 -0700
IronPort-SDR: iIaTm/xG04FiHXFBG2FDVu3VgCQs6Qk6G+prta0oWRypwEPv+Jm8IzV/itDtDzQEVuhrItBErF
 HF65imq2lcig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,404,1592895600"; 
   d="scan'208";a="504934392"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 07 Sep 2020 22:53:15 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH 2/3] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Date:   Tue,  8 Sep 2020 13:48:48 +0800
Message-Id: <1599544129-17594-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Device Feature List (DFL) is a linked list of feature headers within the
device MMIO space. It is used by FPGA to enumerate multiple sub features
within it. Each feature can be uniquely identified by DFL type and
feature id, which can be read out from feature headers.

A dfl bus helps DFL framework modularize DFL device drivers for different
sub features. The dfl bus matches its devices and drivers by DFL type and
feature id.

This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding info
about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
point in file2alias.c.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
---
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 27007c1..d8350ee 100644
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
index 2417dd1..0753fc2 100644
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
+	sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);
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
2.7.4

