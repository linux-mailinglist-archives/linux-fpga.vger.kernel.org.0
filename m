Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF4362616
	for <lists+linux-fpga@lfdr.de>; Fri, 16 Apr 2021 18:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhDPQ4P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 16 Apr 2021 12:56:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:11721 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhDPQ4P (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 16 Apr 2021 12:56:15 -0400
IronPort-SDR: cNlLVOmq2U+697Z94jhZtwqAMfVR/0F8QDuv3VWqyIUvE8NRHGpKUAtZGiNxDbD1/jdQeq3vFR
 hYJtRxE2w/IA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="215606430"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="215606430"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 09:55:49 -0700
IronPort-SDR: Rk5PKcOKypXYtpbTYOxE2eNxdeLq0C1bfWEBt8SWTn+GL8+j2RMTmLi46vkJY0KH1tvGzgbJP6
 JKfycXrMjzrQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="425655933"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 09:55:49 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, trix@redhat.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, yilun.xu@intel.com,
        russell.h.weight@intel.com, broonie@kernel.org,
        linux-spi@vger.kernel.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v3 0/2] spi: altera: Add DFL bus support for Altera SPI
Date:   Fri, 16 Apr 2021 09:57:18 -0700
Message-Id: <20210416165720.554144-1-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

This patch set adds Device Feature List (DFL) bus support for
the Altera SPI Master controller.

Patch 1 separates spi-altera.c into spi-altera-core.c and
spi-altera-platform.c.

Patch 2 adds spi-altera-dfl.c.

Matthew Gerlach (2):
  spi: altera: separate core code from platform code
  spi: altera: Add DFL bus driver for Altera API Controller

 drivers/spi/Kconfig               |  18 +-
 drivers/spi/Makefile              |   4 +-
 drivers/spi/spi-altera-core.c     | 222 ++++++++++++++++++++++
 drivers/spi/spi-altera-dfl.c      | 204 ++++++++++++++++++++
 drivers/spi/spi-altera-platform.c | 172 +++++++++++++++++
 drivers/spi/spi-altera.c          | 378 --------------------------------------
 include/linux/spi/altera.h        |  21 +++
 7 files changed, 639 insertions(+), 380 deletions(-)
 create mode 100644 drivers/spi/spi-altera-core.c
 create mode 100644 drivers/spi/spi-altera-dfl.c
 create mode 100644 drivers/spi/spi-altera-platform.c
 delete mode 100644 drivers/spi/spi-altera.c

-- 
1.8.3.1

