Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE9B277774
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Sep 2020 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgIXRHk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Sep 2020 13:07:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:15601 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728640AbgIXRHj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Sep 2020 13:07:39 -0400
IronPort-SDR: k/fFaKVQ/9l7SK4T5g9E8f3s760bzGJynhNkYhxx9SVhZIER6LZVSxVBofUbdw66/ULWzyXo4E
 bP3e0nIaHkug==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="149026689"
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="149026689"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 10:05:05 -0700
IronPort-SDR: a05pZ8pXqGt4+7oWdqXCbx/9vwMUHyVNFSeoACtxTCm5jjHNSY8h3jomDbfM4fmIyJwS+wrxNu
 83YXlMm2uVQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,298,1596524400"; 
   d="scan'208";a="511697227"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2020 10:04:57 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 4/5] fpga: dfl: add fpga dfl bus support to MODULE_DEVICE_TABLE()
Date:   Fri, 25 Sep 2020 01:00:00 +0800
Message-Id: <1600966801-30586-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
References: <1600966801-30586-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Device Feature List (DFL) is a linked list of feature headers within the
device MMIO space. It is used by FPGA to enumerate multiple sub features
within it. Each feature can be uniquely identified by DFL type and
feature id, which can be read out from feature headers.

A fpga dfl bus helps DFL framework modularize DFL device drivers for
different sub features. The fpga dfl bus matches its devices and drivers
by DFL type and feature id.

This patch adds fpga dfl bus support to MODULE_DEVICE_TABLE() by adding
info about struct fpga_dfl_device_id in devicetable-offsets.c and add a
fpga dfl entry point in file2alias.c.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: add comments for the format of modalias
v3: changes the names from dfl_XXX to fpga_dfl_XXX
    delete the comments of valid bits for modalias format
---
 scripts/mod/devicetable-offsets.c |  4 ++++
 scripts/mod/file2alias.c          | 13 +++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 27007c1..25fe19b 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -243,5 +243,9 @@ int main(void)
 	DEVID(mhi_device_id);
 	DEVID_FIELD(mhi_device_id, chan);
 
+	DEVID(fpga_dfl_device_id);
+	DEVID_FIELD(fpga_dfl_device_id, type);
+	DEVID_FIELD(fpga_dfl_device_id, feature_id);
+
 	return 0;
 }
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 2417dd1..4fffdd5 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1368,6 +1368,18 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
 	return 1;
 }
 
+/* Looks like: fpga-dfl:tNfN */
+static int do_fpga_dfl_entry(const char *filename, void *symval, char *alias)
+{
+	DEF_FIELD(symval, fpga_dfl_device_id, type);
+	DEF_FIELD(symval, fpga_dfl_device_id, feature_id);
+
+	sprintf(alias, "fpga-dfl:t%04Xf%04X", type, feature_id);
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
+	{"fpgadfl", SIZE_fpga_dfl_device_id, do_fpga_dfl_entry},
 };
 
 /* Create MODULE_ALIAS() statements.
-- 
2.7.4

