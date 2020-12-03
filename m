Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0581C2CCFA7
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 07:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgLCGlj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 01:41:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:46312 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgLCGlj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 01:41:39 -0500
IronPort-SDR: Y7o+sfJzgf9QcPcWeGfWnia+ZvO1DG2oD8XsT8wdQEoHhneceh5wLQahm219zABj423dCWtiRw
 G//InBkNk2BQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234748801"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="234748801"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 22:40:53 -0800
IronPort-SDR: RYNGDe/z+iRja028xrz8rsdYSr6HliqW/F5boDz4/lTwVyGARl22HTK2K067dA8iWoa4mE/ngr
 VRurA5GQhn4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="335842316"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga006.jf.intel.com with ESMTP; 02 Dec 2020 22:40:50 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, krzk@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RESEND PATCH v13 3/6] fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
Date:   Thu,  3 Dec 2020 14:35:57 +0800
Message-Id: <1606977360-4421-4-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
References: <1606977360-4421-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

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
v2: add comments for the format of modalias
v3: changes the names from dfl_XXX to fpga_dfl_XXX
    delete the comments of valid bits for modalias format
v9: rebase the patch for bus name changes back to "dfl"
v10: no change
v11: no change
v12: no change
v13: no change
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
index 2417dd1..8a438c9 100644
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
2.7.4

