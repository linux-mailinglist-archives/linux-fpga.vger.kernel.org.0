Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEE64341F3
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Oct 2021 01:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJSXSq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 19 Oct 2021 19:18:46 -0400
Received: from mga17.intel.com ([192.55.52.151]:7453 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJSXSp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 19 Oct 2021 19:18:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="209445769"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="209445769"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="567152170"
Received: from rhweight-mobl.amr.corp.intel.com (HELO rhweight-mobl.ra.intel.com) ([10.212.183.7])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 16:15:49 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v1 0/2] fpga: dfl: Log and clear errors on driver init
Date:   Tue, 19 Oct 2021 16:15:43 -0700
Message-Id: <20211019231545.47118-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

These patches address a request to log and clear any prexisting errors on
FPGA cards when the drivers load. Any existing errors will result in print
statements to the kernel error log before the errors are cleared. These
changes specifically affect the fme and port error registers.

Russ Weight (2):
  fpga: dfl: afu: Clear port errors in afu init
  fpga: dfl: fme: Clear fme global errors at driver init

 drivers/fpga/dfl-afu-error.c |  26 ++++---
 drivers/fpga/dfl-fme-error.c | 128 +++++++++++++++++++++++------------
 2 files changed, 100 insertions(+), 54 deletions(-)

-- 
2.25.1

