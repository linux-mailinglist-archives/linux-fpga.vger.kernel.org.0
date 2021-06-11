Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 973D43A465D
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Jun 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFKQXo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 11 Jun 2021 12:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44964 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229548AbhFKQXo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 11 Jun 2021 12:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623428505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZyQVUGKWLozyDagTOgZnPxq+fMSwxihZuttFhwIij5Q=;
        b=dmk2cnfqiIu1UcN18+iYRRwcyVYmr0GpMtCyggaO6hmI4FqTlfdwU3vf/20qms5/u8Oxq1
        p/+9z8xBU6B4gpKML0S7OJ1xVqBAdriIhd+nEVGW567Etre/06cRJ/5ZVOsus1j9DHFnAQ
        rd1gez82XfUprmbzfGAC9zQB7yaUFQs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-qykiOXNRMvuGDwug0Am2wg-1; Fri, 11 Jun 2021 12:21:44 -0400
X-MC-Unique: qykiOXNRMvuGDwug0Am2wg-1
Received: by mail-oi1-f197.google.com with SMTP id o65-20020acaf0440000b02901f5112008e6so3084354oih.17
        for <linux-fpga@vger.kernel.org>; Fri, 11 Jun 2021 09:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyQVUGKWLozyDagTOgZnPxq+fMSwxihZuttFhwIij5Q=;
        b=qu0UFwu2qF/A7q3FCCaF2ZIbmnh8yDBJhM/iKYltlnnJwUrxn2/L9V9Yjd6Zc2mclp
         HQ2DdkFtEdSF+0UvoVcr2VynY/72zYeXf+uWsoYnOKrWPzcBtHuCUwKngvh9jc0r3mgT
         MR1yob1e5FQOQchqoScFjv0vVaL12wRQ8fvWauEZwv3GaEdriAnDIswT3StyrQ7TiuL1
         u6oHZMFLAej2ZjNGsyhV8I0mYZJdoPw7yU5PC+qEHJHcqOmbLswlCBcc2JFy0c9bjoFy
         xtk7DwPjhkjOoFCg89i0ntNQgxPkAgdfuwpREYTCtRd/VXRYhGzTq2W98gLnRR/8/csy
         WWsw==
X-Gm-Message-State: AOAM533+SgM2yhqj7uST08rOTDa/yXvZWOe28qXgvm2y0vLG45tSfwYO
        uAcWOzIoj3RZCWp2Pvb2x9TeluRM6tJoTV6mhKOFFAymUP4iT5D13gvq3z9sTiv9x63Jj9eFf1Y
        huoazvZRknlXLYnd/+wZmHw==
X-Received: by 2002:aca:4fcc:: with SMTP id d195mr13962897oib.88.1623428503596;
        Fri, 11 Jun 2021 09:21:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWTEiE4o45E/4BXKag1bvdJzLEhoQvSZsH/t/qPwPgzSLZ86f7qH7u0XhJ7PicYAcuAGNVMg==
X-Received: by 2002:aca:4fcc:: with SMTP id d195mr13962876oib.88.1623428503371;
        Fri, 11 Jun 2021 09:21:43 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m18sm1346345otr.61.2021.06.11.09.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 09:21:42 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski@canonical.com,
        dinguyen@kernel.org, nava.manne@xilinx.com, yilun.xu@intel.com,
        davidgow@google.com, fpacheco@redhat.com, richard.gong@intel.com,
        luca@lucaceresoli.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 0/4] fpga: reorganize to subdirs
Date:   Fri, 11 Jun 2021 09:21:24 -0700
Message-Id: <20210611162129.3203483-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The incoming xrt patchset has a toplevel subdir xrt/
The current fpga/ uses a single dir with filename prefixes to subdivide owners
For consistency, there should be only one way to organize the fpga/ dir.
Because the subdir model scales better, refactor to use it.
The discussion wrt xrt is here:
https://lore.kernel.org/linux-fpga/68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com/

Follow drivers/net/ethernet/ which has control configs
NET_VENDOR_BLA that map to drivers/net/ethernet/bla
Since fpgas do not have many vendors, drop the 'VENDOR' and use
FPGA_BLA.

There are several new subdirs
altera/
dfl/
lattice/
xilinx/

Each subdir has a Kconfig that has a new/reused

if FPGA_BLA
  ... existing configs ...
endif FPGA_BLA

Which is sourced into the main fpga/Kconfig

Each subdir has a Makefile whose transversal is controlled in the
fpga/Makefile by

obj-$(CONFIG_FPGA_BLA) += bla/

Some cleanup to arrange thing alphabetically and make fpga/Makefile's
whitespace look more like net/'s

Changes from
v1
  Drop renaming files
  Cleanup makefiles

v2
  Expand commit messages
  Add SPDX to Kconfig
  Expand new Kconfig variable help messages

Tom Rix (4):
  fpga: dfl: reorganize to subdir layout
  fpga: xilinx: reorganize to subdir layout
  fpga: altera: reorganize to subdir layout
  fpga: lattice: reorganize to subdir layout

 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          | 204 +-----------------
 drivers/fpga/Makefile                         |  47 +---
 drivers/fpga/altera/Kconfig                   |  85 ++++++++
 drivers/fpga/altera/Makefile                  |  12 ++
 drivers/fpga/{ => altera}/altera-cvp.c        |   0
 drivers/fpga/{ => altera}/altera-fpga2sdram.c |   0
 .../fpga/{ => altera}/altera-freeze-bridge.c  |   0
 drivers/fpga/{ => altera}/altera-hps2fpga.c   |   0
 .../{ => altera}/altera-pr-ip-core-plat.c     |   0
 drivers/fpga/{ => altera}/altera-pr-ip-core.c |   0
 drivers/fpga/{ => altera}/altera-ps-spi.c     |   0
 drivers/fpga/{ => altera}/socfpga-a10.c       |   0
 drivers/fpga/{ => altera}/socfpga.c           |   0
 drivers/fpga/{ => altera}/stratix10-soc.c     |   0
 drivers/fpga/{ => altera}/ts73xx-fpga.c       |   0
 drivers/fpga/dfl/Kconfig                      |  83 +++++++
 drivers/fpga/dfl/Makefile                     |  16 ++
 drivers/fpga/{ => dfl}/dfl-afu-dma-region.c   |   0
 drivers/fpga/{ => dfl}/dfl-afu-error.c        |   0
 drivers/fpga/{ => dfl}/dfl-afu-main.c         |   0
 drivers/fpga/{ => dfl}/dfl-afu-region.c       |   0
 drivers/fpga/{ => dfl}/dfl-afu.h              |   0
 drivers/fpga/{ => dfl}/dfl-fme-br.c           |   0
 drivers/fpga/{ => dfl}/dfl-fme-error.c        |   0
 drivers/fpga/{ => dfl}/dfl-fme-main.c         |   0
 drivers/fpga/{ => dfl}/dfl-fme-mgr.c          |   0
 drivers/fpga/{ => dfl}/dfl-fme-perf.c         |   0
 drivers/fpga/{ => dfl}/dfl-fme-pr.c           |   0
 drivers/fpga/{ => dfl}/dfl-fme-pr.h           |   0
 drivers/fpga/{ => dfl}/dfl-fme-region.c       |   0
 drivers/fpga/{ => dfl}/dfl-fme.h              |   0
 drivers/fpga/{ => dfl}/dfl-n3000-nios.c       |   0
 drivers/fpga/{ => dfl}/dfl-pci.c              |   0
 drivers/fpga/{ => dfl}/dfl.c                  |   0
 drivers/fpga/{ => dfl}/dfl.h                  |   0
 drivers/fpga/lattice/Kconfig                  |  29 +++
 drivers/fpga/lattice/Makefile                 |   4 +
 drivers/fpga/{ => lattice}/ice40-spi.c        |   0
 drivers/fpga/{ => lattice}/machxo2-spi.c      |   0
 drivers/fpga/xilinx/Kconfig                   |  55 +++++
 drivers/fpga/xilinx/Makefile                  |   6 +
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |   0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |   0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |   0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |   0
 46 files changed, 303 insertions(+), 240 deletions(-)
 create mode 100644 drivers/fpga/altera/Kconfig
 create mode 100644 drivers/fpga/altera/Makefile
 rename drivers/fpga/{ => altera}/altera-cvp.c (100%)
 rename drivers/fpga/{ => altera}/altera-fpga2sdram.c (100%)
 rename drivers/fpga/{ => altera}/altera-freeze-bridge.c (100%)
 rename drivers/fpga/{ => altera}/altera-hps2fpga.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core-plat.c (100%)
 rename drivers/fpga/{ => altera}/altera-pr-ip-core.c (100%)
 rename drivers/fpga/{ => altera}/altera-ps-spi.c (100%)
 rename drivers/fpga/{ => altera}/socfpga-a10.c (100%)
 rename drivers/fpga/{ => altera}/socfpga.c (100%)
 rename drivers/fpga/{ => altera}/stratix10-soc.c (100%)
 rename drivers/fpga/{ => altera}/ts73xx-fpga.c (100%)
 create mode 100644 drivers/fpga/dfl/Kconfig
 create mode 100644 drivers/fpga/dfl/Makefile
 rename drivers/fpga/{ => dfl}/dfl-afu-dma-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-afu.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-br.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-error.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-main.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-mgr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-perf.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-pr.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme-region.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-fme.h (100%)
 rename drivers/fpga/{ => dfl}/dfl-n3000-nios.c (100%)
 rename drivers/fpga/{ => dfl}/dfl-pci.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.c (100%)
 rename drivers/fpga/{ => dfl}/dfl.h (100%)
 create mode 100644 drivers/fpga/lattice/Kconfig
 create mode 100644 drivers/fpga/lattice/Makefile
 rename drivers/fpga/{ => lattice}/ice40-spi.c (100%)
 rename drivers/fpga/{ => lattice}/machxo2-spi.c (100%)
 create mode 100644 drivers/fpga/xilinx/Kconfig
 create mode 100644 drivers/fpga/xilinx/Makefile
 rename drivers/fpga/{ => xilinx}/xilinx-pr-decoupler.c (100%)
 rename drivers/fpga/{ => xilinx}/xilinx-spi.c (100%)
 rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
 rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)

-- 
2.26.3

