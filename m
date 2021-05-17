Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61E63822C2
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhEQCeA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:00 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:36738 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEQCd7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:33:59 -0400
Received: by mail-pg1-f176.google.com with SMTP id 27so2336136pgy.3
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C1IGQTbdk5om1ZF6VZwZ052BTN1TShmwBNhqgA4xeWw=;
        b=G3ouqYhQXQfqPShx6ulRXr+W7zFLqz5WDXxJXwEDnfqU6Y6mF8u1f1ExVsyGLeRwYZ
         Py23hZOn5mKttZLDdExiTBOObELiPc+yKmDFMOeR+UInDOtCgCPtdq4IcdRLGNhhYlVW
         ozB5SUybmHVsWN/3XJyWuKgzIzsxXIO5AdVXKTnBd21cTrsAyxEM1BaD9RmNe75SUwDV
         KFQlnK+xDGECQltibdVfwOHtAFlZG6X/Wp6l5YRMQuKVRm0t5dS9fjwv3jj92t4+lGIt
         hT+OL9Yv7fVLBReSFuB+y9CWbwJ4mAEXIGlfb/dRxqx0B3hf/o03h985F1Nxd+m6tOAs
         luIA==
X-Gm-Message-State: AOAM5337N16wOSIZfl+E1DS2C9hY60KLwMMRPZNvpYZgiGj5HQXkaAej
        h3h7AztiQkXDKAGfl9iSaQ9DwrpXzIXzXjRc
X-Google-Smtp-Source: ABdhPJyUBYEzNf32pMvXy4b3E2MN73E4/xL8gSQkvkcoDLcSymfF3XR95pYz+7BJWK6gA62CGzACiw==
X-Received: by 2002:aa7:8a1a:0:b029:2d4:a24:8967 with SMTP id m26-20020aa78a1a0000b02902d40a248967mr16890042pfa.11.1621218764072;
        Sun, 16 May 2021 19:32:44 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a18sm8839499pfn.147.2021.05.16.19.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:43 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/12] FPGA Security Manager for 5.14
Date:   Sun, 16 May 2021 19:31:48 -0700
Message-Id: <20210517023200.52707-1-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

please consider these patches for inclusion into 5.14.

Russ' changes introduce a new framework that enables secure updates of
FPGA devices boot configuration by interacting with the secure HW
engine.

The use cases for the FPGA Security Manager which deals with the update
of the permanent image for the FPGA device do not overlap enough with
the FPGA Manage use case (runtime updates of the currently loaded
image) to warrant a tighter coupling.

Its first user is m10bmc-sec driver supporting the Intel MAX 10 BMC
device.

Thanks,
Moritz

Russ Weight (12):
  fpga: sec-mgr: fpga security manager class driver
  fpga: sec-mgr: enable secure updates
  fpga: sec-mgr: expose sec-mgr update status
  fpga: sec-mgr: expose sec-mgr update errors
  fpga: sec-mgr: expose sec-mgr update size
  fpga: sec-mgr: enable cancel of secure update
  fpga: sec-mgr: expose hardware error info
  fpga: m10bmc-sec: create max10 bmc secure update driver
  fpga: m10bmc-sec: expose max10 flash update count
  fpga: m10bmc-sec: expose max10 canceled keys in sysfs
  fpga: m10bmc-sec: add max10 secure update functions
  fpga: m10bmc-sec: add max10 get_hw_errinfo callback func

 .../ABI/testing/sysfs-class-fpga-sec-mgr      |  81 +++
 .../testing/sysfs-driver-intel-m10-bmc-secure |  61 ++
 Documentation/fpga/fpga-sec-mgr.rst           |  44 ++
 Documentation/fpga/index.rst                  |   1 +
 MAINTAINERS                                   |  11 +
 drivers/fpga/Kconfig                          |  20 +
 drivers/fpga/Makefile                         |   6 +
 drivers/fpga/fpga-sec-mgr.c                   | 648 ++++++++++++++++++
 drivers/fpga/intel-m10-bmc-secure.c           | 550 +++++++++++++++
 include/linux/fpga/fpga-sec-mgr.h             |  99 +++
 10 files changed, 1521 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
 create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
 create mode 100644 drivers/fpga/fpga-sec-mgr.c
 create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
 create mode 100644 include/linux/fpga/fpga-sec-mgr.h

-- 
2.31.1

