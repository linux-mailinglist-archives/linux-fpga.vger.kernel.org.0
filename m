Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18723A1705
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Jun 2021 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhFIOYd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 9 Jun 2021 10:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235827AbhFIOYO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 9 Jun 2021 10:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623248539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pJmqxzT8uSof7JvXwU0e58Z2K6C1TfI+K5YVC+evFiE=;
        b=D/mzUEavIITh10R2gCJcBw/XMOIzhFkXFcWsRBNMU7n/BX7c907Ut1jC3fPNuEVFqdmItT
        k3M3993zdFIussuDudiC9UWbQ0W5njRNYXoEe/dbVr2GNNXsc7lB+DWOOBotZQA2PiyTMC
        Yqy5pjJ/lxAUm8wpsbifC6LfqBIIk0U=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-soub762JNMqwNGdY4dw7AQ-1; Wed, 09 Jun 2021 10:22:18 -0400
X-MC-Unique: soub762JNMqwNGdY4dw7AQ-1
Received: by mail-oo1-f72.google.com with SMTP id n62-20020a4a53410000b0290246a4799849so15009344oob.8
        for <linux-fpga@vger.kernel.org>; Wed, 09 Jun 2021 07:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pJmqxzT8uSof7JvXwU0e58Z2K6C1TfI+K5YVC+evFiE=;
        b=rDKANwsd3dwcxE67WeXg9tCM6CcQsCuB+Z3l36cdDti0iZzxoTLPKIOtVXBf54dlbj
         WHWH949dU6Ty4tXcPy+U6IXzCTP20YEMRKd8MVNxMotBi/98jyN5ODEFT7YDPyq11Xpa
         TsMgw/YcCmTZTJYEHB7Drm9R5sRSQNbgQumDcSUBvlDnJ/te6EnOxAGJVSKlK5mPAyRB
         n5sU2f5GcCbpdRt1lrUNrpnCYO0ZQcFmaMT6ule+nPP3DGQ9WiUJoEnDpsFVbydfxMmP
         Q7jr0atd9j50YBSBPSAnt+tOlOm0ojUd9WqiA46y6JmoCau3+BGyOgmpu77gG/GwGpu9
         TPfw==
X-Gm-Message-State: AOAM533otvDrmP3qtv7s5QodeGDDbCeiTWDoxBQ1xmdIChbG6rFvddxG
        xFKw9dGkRxC2NSCuenH0nGNa4mBnTLiC5h/ynmHvjaYn9Pxn8zy+3y3xSKZooyARhZ4TamTHCVb
        ozCOfiHQ2Vakkx5S3k+h5WA==
X-Received: by 2002:a54:4692:: with SMTP id k18mr6628944oic.118.1623248537329;
        Wed, 09 Jun 2021 07:22:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtTQNkYbadoKGH9x829Ut7eBbGhSJab/deluCz5u6zv1Bar6KI8Zg7PNZ+5UFKoVUqd1XH+g==
X-Received: by 2002:a54:4692:: with SMTP id k18mr6628919oic.118.1623248537059;
        Wed, 09 Jun 2021 07:22:17 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o4sm3414432oon.15.2021.06.09.07.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 07:22:16 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com,
        gregkh@linuxfoundation.org, nava.manne@xilinx.com,
        dinguyen@kernel.org, krzysztof.kozlowski@canonical.com,
        yilun.xu@intel.com, arnd@arndb.de, fpacheco@redhat.com,
        richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/4]  fpga: reorganize to subdirs
Date:   Wed,  9 Jun 2021 07:22:03 -0700
Message-Id: <20210609142208.3085451-1-trix@redhat.com>
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

Tom Rix (4):
  fpga: dfl: reorganize to subdir layout
  fpga: xilinx: reorganize to subdir layout
  fpga: altera: reorganize to subdir layout
  fpga: lattice: reorganize to subdir layout

 MAINTAINERS                                   |   2 +-
 drivers/fpga/Kconfig                          | 204 +-----------------
 drivers/fpga/Makefile                         |  47 +---
 drivers/fpga/altera/Kconfig                   |  78 +++++++
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
 drivers/fpga/dfl/Kconfig                      |  81 +++++++
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
 drivers/fpga/lattice/Kconfig                  |  22 ++
 drivers/fpga/lattice/Makefile                 |   4 +
 drivers/fpga/{ => lattice}/ice40-spi.c        |   0
 drivers/fpga/{ => lattice}/machxo2-spi.c      |   0
 drivers/fpga/xilinx/Kconfig                   |  48 +++++
 drivers/fpga/xilinx/Makefile                  |   6 +
 .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |   0
 drivers/fpga/{ => xilinx}/xilinx-spi.c        |   0
 drivers/fpga/{ => xilinx}/zynq-fpga.c         |   0
 drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |   0
 46 files changed, 280 insertions(+), 240 deletions(-)
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

