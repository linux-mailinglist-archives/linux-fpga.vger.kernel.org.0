Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B22828F7
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 07:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbgJDFOs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 01:14:48 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:56167 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgJDFOs (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 01:14:48 -0400
Received: by mail-pj1-f45.google.com with SMTP id ds1so349999pjb.5;
        Sat, 03 Oct 2020 22:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5jCXvwJwj1z68C+tUg1f0/JWK2fgneBein9sKZvrOZc=;
        b=bi6+vycHJwPjCR3clg+6zt9baOdtWShGZkFv6LQgV89rDRAnE/ssMhktSHBi44P/G3
         iZEOULHjBhLI7BL+3LmRb9U/x6LO/2eSYvz/8GqUaeDEupRXRsjWTmFh7G5rMwz/4uuN
         abrORgK5kVk+Q+s6s48kOurZELvhYHaP/T/5TwbQ1490FWWWi6xKwwpdBnJpbrxHzCtJ
         5CvwkVYhpmKRP5PVqWx27l/6f1m8q9MVlDpyfFnu9T8WGnV3ztG93/nGfj03YRAUwSlj
         0U1Ngkucp965i17TRlRuphbIeL3TBYAW1GwZkb+OoN9jocUJcoMWphFvI8ewfHN08ZHg
         ruwg==
X-Gm-Message-State: AOAM533LwIrdFJPS5BgcS3JXnhFNgvw0odTEBQybKLsjKNOefM9dN/Dt
        okJYus1jv9DoOBKufrY5HsGgl25XEGc=
X-Google-Smtp-Source: ABdhPJy4U8/xcmaB/wuflUJgl87G7F41tguJSnQzhm5FjRDFX7tKah4ZsAXoJCkD1nL04gD61ujTDw==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr3628437pjj.41.1601788487052;
        Sat, 03 Oct 2020 22:14:47 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u14sm7449820pfm.80.2020.10.03.22.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 22:14:46 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/10] Introduce devm_fpga_mgr_register()
Date:   Sat,  3 Oct 2020 22:14:13 -0700
Message-Id: <20201004051423.75879-1-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patchset introduces the devm_fpga_mgr_register API,
a devres managed version of fpga_mgr_register().

It reduces boilerplate being repeated literally in every
single driver by moving it to the fpga-mgr core.

Moritz Fischer (10):
  fpga: fpga-mgr: Add devm_fpga_mgr_register() API
  fpga: fpga-mgr: altera-ps-spi: Simplify registration
  fpga: fpga-mgr: dfl-fme-mgr: Simplify registration
  fpga: fpga-mgr: ice40-spi: Simplify registration
  fpga: fpga-mgr: machxo2-spi: Simplify registration
  fpga: fpga-mgr: socfpga: Simplify registration
  fpga: fpga-mgr: ts73xx: Simplify registration
  fpga: fpga-mgr: xilinx-spi: Simplify registration
  fpga: fpga-mgr: zynqmp: Simplify registration
  fpga: fpga-mgr: altera-pr-ip: Simplify registration

 drivers/fpga/altera-pr-ip-core-plat.c  | 10 ----
 drivers/fpga/altera-pr-ip-core.c       | 14 +----
 drivers/fpga/altera-ps-spi.c           | 14 +----
 drivers/fpga/dfl-fme-mgr.c             | 12 +---
 drivers/fpga/fpga-mgr.c                | 76 ++++++++++++++++++++++----
 drivers/fpga/ice40-spi.c               | 14 +----
 drivers/fpga/machxo2-spi.c             | 14 +----
 drivers/fpga/socfpga.c                 | 14 +----
 drivers/fpga/ts73xx-fpga.c             | 14 +----
 drivers/fpga/xilinx-spi.c              | 14 +----
 drivers/fpga/zynqmp-fpga.c             | 21 +------
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 include/linux/fpga/fpga-mgr.h          |  2 +
 13 files changed, 77 insertions(+), 143 deletions(-)

-- 
2.28.0

