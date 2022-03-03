Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACA4CB3D8
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Mar 2022 01:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiCCAeZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 2 Mar 2022 19:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiCCAeY (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 2 Mar 2022 19:34:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929CA2A247;
        Wed,  2 Mar 2022 16:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267612; x=1677803612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AtpgHhEcXv/UG0lpYPd3jZdY+ZcggbadahmJ+GNcs0U=;
  b=lM1uhNlAHEZ9GmpSvlg3BHUFUM9gJG08117J7BViOjVkgkiO3MLuNXf+
   9NS84Nn3ZtHNIH2VdRLkVdQQJ+aP/JPCoAPDnzMEVJqxe/xpBztf9TTvQ
   QLOWr/CyG3rwAAnOPZK7axpNlDeoAARiUsFtj/mCV+ZmvesPFv0cqmftL
   JLjcGeUkHmsLMWVFLuqK1DvrJD6WAin9sqiUKPUv4b4vNrp0c78Mamsgw
   fm4V3qh6M5AZ6AxW7XkqcMufD3+3fziQ1NAoHW9FUwVRm3up4JM+wynm8
   Gflg8eGCaS+ZxW+fv53BzzsXSMZS3ofAqOc+KVgiOm3YdGerZ9ZoXafR1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253468947"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253468947"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:32 -0800
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="686309304"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:33:31 -0800
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, corbet@lwn.net, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, ashok.raj@intel.com,
        tianfei.zhang@intel.com
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v2 0/2] Add PCIE device IDs for Intel DFL cards
Date:   Wed,  2 Mar 2022 16:35:32 -0800
Message-Id: <20220303003534.3307971-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds the PCIE device IDs for Intel cards with Device Feature
Lists (DFL) to the pci_dev_table for the dfl-pci driver.  This patch set
was separated for clarity from a larger patch set submitted by
tianfei.zhang@intel.com.

Patch 1 adds documentation about identifying PCIE FPGA cards
with Device Feature Lists (DFL).

Patch 2 adds the device ids to the pci_dev_table for the dfl-pci driver.

Matthew Gerlach (2):
  Documentation: fpga: dfl: add PCI Identification documentation
  drivers: fpga: dfl-pci: Add PCIE device IDs for Intel DFL cards

 Documentation/fpga/dfl.rst | 20 ++++++++++++++++++++
 drivers/fpga/dfl-pci.c     |  4 ++++
 2 files changed, 24 insertions(+)

-- 
2.25.1

