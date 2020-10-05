Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F0A283DA4
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgJERkA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:40:00 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:37673 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgJERkA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:40:00 -0400
Received: by mail-pj1-f54.google.com with SMTP id kk9so216204pjb.2;
        Mon, 05 Oct 2020 10:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GDA9XWEwfWUACRI3I02tabmvwJriNb6PloGbU7B9IZA=;
        b=ZT97kNfIjo2nYxC9gdT9VBU9H1aD0kPYx1ewD3HhJWDzsUesm+rmg9xmnpEBRgOdTC
         nsxeG3b3zO/Tc2LTpExAG+Q8d6Op1zq98UDbThsIDNB2NsA00AGD3ttzMqOm2xG3oVym
         T+zihNNRfLNMn161xvMCa4jabc/ZValBQjJbWBuz+RCi/+9Z1JOfHN10GE8cGMQ8cqJg
         KKOiYW4BPMtT54vpCDnvpFSwVbiPVhFIJEmgsA6NoIga+oWckhDCRh5QLU7+JCuKU7jx
         Orefl7PxNJXhaxLobiZluNV0jRpVE4oyQKOM/T82oecVoZxMUYsOX5sAaLfD2/j0dbKk
         FLDQ==
X-Gm-Message-State: AOAM533BRuuLyzq/YVPxZMiLBMxcwQDfYTIwUHrGflq0hyn6VRDFAfkZ
        TU1tLtJnlyMlxq19F+ONoECIE/7ckcA=
X-Google-Smtp-Source: ABdhPJyP4uenJIHIL9ii7ZS1fb84Bg/SQbJU69tmKcumhfod92ZA08l23qgg+AiiuyheK4VfYa/h3w==
X-Received: by 2002:a17:90a:8585:: with SMTP id m5mr488991pjn.69.1601919599534;
        Mon, 05 Oct 2020 10:39:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id y12sm238029pga.53.2020.10.05.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:39:58 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 00/10] Introduce devm_fpga_mgr_register()
Date:   Mon,  5 Oct 2020 10:39:57 -0700
Message-Id: <20201005173957.162690-1-mdf@kernel.org>
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
