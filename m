Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D592D224805
	for <lists+linux-fpga@lfdr.de>; Sat, 18 Jul 2020 04:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGRCT5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 17 Jul 2020 22:19:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42182 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgGRCT4 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 17 Jul 2020 22:19:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id q17so6165003pls.9;
        Fri, 17 Jul 2020 19:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hMo3RnVDHLfIgbhzSPhgmZoRSeQMkJc26fstu4GMgpI=;
        b=jwQbYl1klINeHhqCIrAFMbBOq89nB6Sy7/u/yq1ilYGIzxuAhz+NOs07//gX4ThO7i
         VvJkyaKXpbEEMX8ipYKX2ISO6abE1mAz6qvbtVG6m6wu/5bJXP4S07nBpKKZceuOY6LO
         CgM+iU7mD5mWvWOoF7KzxD8+jSkeUzAiHN62w7YWDYVatUDnBAL3KBb9BdCN2B8YBMLr
         Vw8kLwcnFuucOjyyT0PlMnyqu1tdN3ine0OVfom6kf2ijsbI2mlNE53zTBsFIvYAZ1cv
         DIdZ+Lkt4O6BGFwUV+lggsOZ94N6rLaUe+O3cVjLy1i2fFfAnZULsD5p7YAzNMc6KXL/
         OxQg==
X-Gm-Message-State: AOAM533YVSzgoQMSJnqksvxYWaTRmzKurclDI5+zBIRse7XC36pB5q4C
        Nrh+Yr8c8uzEmMA3v+EvP3Y=
X-Google-Smtp-Source: ABdhPJy0fCz6ydpJxWLhNYxgvkgzQETsYJdF5tyvpO/Fw2Kg7Tb7d73qzy2TlAHuYYfoYR+JjqdKew==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr3402219plo.129.1595038795782;
        Fri, 17 Jul 2020 19:19:55 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id g4sm9112230pgn.64.2020.07.17.19.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 19:19:55 -0700 (PDT)
Date:   Fri, 17 Jul 2020 19:19:54 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] FPGA Manager changes for 5.9-rc1
Message-ID: <20200718021954.GA7272@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.9

for you to fetch changes up to eacfbf589c904bf8362cbd2d6cac123b0230e272:

  fpga: dfl: pci: add device id for Intel FPGA PAC N3000 (2020-07-12 19:00:37 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.9-rc1

Here is the (slightly larger than usual) patch set for the 5.9-rc1 merge
window.

DFL:
- Xu's changes add support for AFU interrupt handling and puts them to
  use for error handling.
- Xu's other change also adds another device-id for the Intel FPGA PAC N3000.
- John's change converts from using get_user_pages() to
  pin_user_pages().
- Gustavo's patch cleans up some of the allocation by using
  struct_size().

Xilinx:
- Luca's changes clean up the xilinx-spi and xilinx-slave-serial drivers
  and updates the comments and dt-bindings to reflect the fact it also
  supports 7 series devices.

Core:
- Tom cleaned up the fpga-bridge / fpga-mgr core by removing some
  dead-stores.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      fpga: dfl: Use struct_size() in kzalloc()

John Hubbard (1):
      fpga: dfl: afu: convert get_user_pages() --> pin_user_pages()

Luca Ceresoli (5):
      dt-bindings: fpga: xilinx-slave-serial: valid for the 7 Series too
      fpga manager: xilinx-spi: valid for the 7 Series too
      fpga manager: xilinx-spi: remove unneeded, mistyped variables
      dt-bindings: fpga: xilinx-slave-serial: add optional INIT_B GPIO
      fpga manager: xilinx-spi: check INIT_B pin during write_init

Tom Rix (2):
      fpga: Fix dead store fpga-mgr.c
      fpga: Fix dead store in fpga-bridge.c

Xu Yilun (8):
      fpga: dfl: parse interrupt info for feature devices on enumeration
      fpga: dfl: pci: add irq info for feature devices enumeration
      fpga: dfl: introduce interrupt trigger setting API
      fpga: dfl: afu: add interrupt support for port error reporting
      fpga: dfl: fme: add interrupt support for global error reporting
      fpga: dfl: afu: add AFU interrupt support
      Documentation: fpga: dfl: add descriptions for interrupt related interfaces.
      fpga: dfl: pci: add device id for Intel FPGA PAC N3000

 .../bindings/fpga/xilinx-slave-serial.txt          |  16 +-
 Documentation/fpga/dfl.rst                         |  19 ++
 drivers/fpga/dfl-afu-dma-region.c                  |  19 +-
 drivers/fpga/dfl-afu-error.c                       |  17 ++
 drivers/fpga/dfl-afu-main.c                        |  32 +++
 drivers/fpga/dfl-fme-error.c                       |  18 ++
 drivers/fpga/dfl-fme-main.c                        |   6 +
 drivers/fpga/dfl-pci.c                             |  78 ++++-
 drivers/fpga/dfl.c                                 | 313 ++++++++++++++++++++-
 drivers/fpga/dfl.h                                 |  63 ++++-
 drivers/fpga/fpga-bridge.c                         |   6 +-
 drivers/fpga/fpga-mgr.c                            |   4 +-
 drivers/fpga/xilinx-spi.c                          |  61 +++-
 include/uapi/linux/fpga-dfl.h                      |  82 ++++++
 14 files changed, 687 insertions(+), 47 deletions(-)
