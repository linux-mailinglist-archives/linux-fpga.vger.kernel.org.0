Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAA5283D9A
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgJERio (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:44 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:42480 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbgJERho (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:44 -0400
Received: by mail-pg1-f180.google.com with SMTP id m34so6439807pgl.9;
        Mon, 05 Oct 2020 10:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aprF6xPNXCBOuFtymro1Q67MneG20sCa3QmW8wApzg0=;
        b=Pb+afr6GQVteC2e0wjWMCMwy2Mvxxxj6MP0UKvec6gEIn0hy/kqFxahhpDmDDb5oVL
         nx4MhFY6b2CpZ/0ijlMgyHdWhk7+0Z8Dn6rtRSDDbhX2y7May6MuhE0bjjBQzeThDtQl
         ODCbfL5pRLr1BujIKpUKU26Qoa2/oShlP1bnxEKIYlhlR1Al48/3yPNruNa0ODgTcI2X
         fsiNyntIpFBPdlEE7NLjBI/xauPA5eF3qYivT8/McmrOgU7S09u6/jnUo5NTUUPN05eu
         RE78YQtEolF7OeQHdA8FHBsAuOmPlVadSr6d2U6dy9VSnfIMJGPdrM66v2Y4y/iHHgsR
         z/bQ==
X-Gm-Message-State: AOAM53362uOFAzy7XG+j52dGqX3QkwrPe9kw7eaP63jWOMmjaNYUsD38
        RBqtN1d5snWoaX+pYfY9DdiBkahIXyU=
X-Google-Smtp-Source: ABdhPJwniWOSMbFSjPxJ6/MdmZDNFYQCSiMqaAq/lQXov41zECxvvGSNwxqem1FZGOOeRI+Y8N5zGg==
X-Received: by 2002:a63:5c19:: with SMTP id q25mr558011pgb.17.1601919462992;
        Mon, 05 Oct 2020 10:37:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id b1sm528905pft.127.2020.10.05.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:42 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: 
Date:   Mon,  5 Oct 2020 10:37:25 -0700
Message-Id: <20201005173735.162408-1-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Subject: [PATCH v2 00/10] Introduce devm_fpga_mgr_register()

This patchset introduces the devm_fpga_mgr_register API,
a devres managed version of fpga_mgr_register().

It reduces boilerplate being repeated literally in every
single driver by moving it to the fpga-mgr core.

Changes from v1:
- Addressed Hao's feedback
   - priv -> res
   - comment style
   - use fpga_mgr_devres consistently

- Addressed Tom's feedback
   - err -> ret
   - removed removal of deprecated API
   - added Reviewed-by: tags

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
