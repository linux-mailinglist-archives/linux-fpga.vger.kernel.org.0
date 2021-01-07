Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622FC2EC964
	for <lists+linux-fpga@lfdr.de>; Thu,  7 Jan 2021 05:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAGEjB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 6 Jan 2021 23:39:01 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:45395 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbhAGEjB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 6 Jan 2021 23:39:01 -0500
Received: by mail-pg1-f178.google.com with SMTP id v19so3969127pgj.12;
        Wed, 06 Jan 2021 20:38:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=onitCBuokTYDXRoVEN/uFmLYnneMswAzM8mHLGXS6ho=;
        b=BZ0loy9elWAS3u7ETlMLcvGVyusKbQ/f7BOayRZ+Fy/rJxB7pG20wR06qH//rQsljf
         L2yQZczph8Vm4H/mZO5EHHVmVbJhDhWL62aV0s3OO0eCA2VpUUZeF5RNfBAt1KDkAbQS
         AAh0b3KjCvexE2GjC5V27gGYl5ECcw6t28yD5hwZtCicJLQbH+l9MSr6f2qekSXBQWjA
         i2iHE9Fljox4OIPu3hhdonk50NVB9V1OAk7MsgA9zX3cQMXCJwilcFKfzpF6Yb+GjEyB
         9T9p9ka/lSNEmTQhm9chjSk+xI5+/rcjSOhsrNGuC8WjhDucSOj8RqtHoKX3mSgaERZx
         PvTw==
X-Gm-Message-State: AOAM531TVTJQRaphUcq3HCYj8aO5Wcw/qpMimKl4Dqrg0XBk4pN73N7S
        /207o6+OWXShbrwfpcRJPcn8OdJP+bw=
X-Google-Smtp-Source: ABdhPJwJfCnybMADoR1Z6gRyUJgGiGh8pphf4a5lNxDNPOGtE/eyszDbW5y4PCFoCeSSmJ7kLJSPVg==
X-Received: by 2002:a63:6207:: with SMTP id w7mr3841pgb.164.1609994300199;
        Wed, 06 Jan 2021 20:38:20 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 14sm3935019pfi.131.2021.01.06.20.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 20:38:19 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/8] FPGA DFL Changes for 5.12
Date:   Wed,  6 Jan 2021 20:37:06 -0800
Message-Id: <20210107043714.991646-1-mdf@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This is a resend of the previous (unfortunately late) patchset of
changes for FPGA DFL.

This contains Matthew's changes to allow for more flexible discovery of
DFLs.

Xu's changeset adds support for DFL device drivers. Two of the first
users are part of the patchset: dfl-emif a memory controller, as well as
support for the NIOS N3000.

Thanks,
Moritz

Matthew Gerlach (2):
  fpga: dfl: refactor cci_enumerate_feature_devs()
  fpga: dfl-pci: locate DFLs by PCIe vendor specific capability

Xu Yilun (6):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h
  fpga: dfl: add support for N3000 Nios private feature
  memory: dfl-emif: add the DFL EMIF private feature driver

 .../ABI/testing/sysfs-bus-dfl-devices-emif    |  25 +
 .../testing/sysfs-bus-dfl-devices-n3000-nios  |  47 ++
 Documentation/fpga/dfl.rst                    |  27 +
 MAINTAINERS                                   |   3 +-
 drivers/fpga/Kconfig                          |  11 +
 drivers/fpga/Makefile                         |   2 +
 drivers/fpga/dfl-n3000-nios.c                 | 588 ++++++++++++++++++
 drivers/fpga/dfl-pci.c                        | 165 +++--
 drivers/fpga/dfl.c                            |   4 +-
 drivers/fpga/dfl.h                            |  85 +--
 drivers/memory/Kconfig                        |   9 +
 drivers/memory/Makefile                       |   2 +
 drivers/memory/dfl-emif.c                     | 207 ++++++
 include/linux/dfl.h                           |  86 +++
 include/linux/mod_devicetable.h               |  24 +
 scripts/mod/devicetable-offsets.c             |   4 +
 scripts/mod/file2alias.c                      |  13 +
 17 files changed, 1180 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-emif
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 drivers/memory/dfl-emif.c
 create mode 100644 include/linux/dfl.h

-- 
2.30.0

