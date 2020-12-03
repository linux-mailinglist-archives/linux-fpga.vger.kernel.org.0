Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C182CDC31
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Dec 2020 18:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501906AbgLCRQR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 12:16:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:55799 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgLCRQR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 12:16:17 -0500
IronPort-SDR: 7KDHfi9/ySp4R7wlc0bbL5eQ/MbDfxT/YXyCemr+cu+Eu+LNG0F5H0OXsOAeCes/lxuVEoy2sI
 RshKjVoGOg1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="153060631"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="153060631"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:35 -0800
IronPort-SDR: TePtxIs3Xiq3kq95pCH+PyG1AdMx4hMud//tHp0wt57v46xM4gHxja3UmI4LRHgRsB5vuV4sGc
 oqvCdxw2Jdug==
X-IronPort-AV: E=Sophos;i="5.78,390,1599548400"; 
   d="scan'208";a="336032783"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.140])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 09:14:35 -0800
From:   matthew.gerlach@linux.intel.com
To:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v4 0/2] fpga: dfl: optional VSEC for start of dfl
Date:   Thu,  3 Dec 2020 09:15:46 -0800
Message-Id: <20201203171548.1538178-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

The start of a Device Feature List (DFL) is currently assumed to be at
Bar0/Offset 0 on the PCIe bus by drivers/fpga/dfl-pci.c.  This patchset
adds support for the start one or more DFLs to be specified in a
Vendor-Specific Capability (VSEC) structure in PCIe config space.  If no
such VSEC structure exists, then the start is assumed to be
Bar0/Offset 0 for backward compatibility.

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl-pci: locate DFLs by PCIe vendor specific capability

 Documentation/fpga/dfl.rst |  27 ++++++
 drivers/fpga/dfl-pci.c     | 165 +++++++++++++++++++++++++++++--------
 2 files changed, 157 insertions(+), 35 deletions(-)

-- 
2.25.2

