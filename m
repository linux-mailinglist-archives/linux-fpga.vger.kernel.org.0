Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200EE2B38DA
	for <lists+linux-fpga@lfdr.de>; Sun, 15 Nov 2020 20:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgKOTvc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 Nov 2020 14:51:32 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44186 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbgKOTvb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 Nov 2020 14:51:31 -0500
Received: by mail-pf1-f173.google.com with SMTP id y7so11337865pfq.11;
        Sun, 15 Nov 2020 11:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2y3nFXVIthhY6LVq2CBgR8rtc7Z1EcMeK+Ye83HMPxM=;
        b=OYm/ZKmttPkVH7k8nE3FlPO6cNDLMmLqpXE1yK1cd6kf/Hi8vkRmQyBhmRDa6Zw4W6
         HZCOY9bjiwpGItRDoy7EjnnQX8/ua57vpBUmAijetKvTGXK1hZg4MX07/7yoGeo/Su12
         77adv1tAR/cIFXuvcDVBaVA+R/Z6VEpcXpMwPmawTQMIW6wRF6CYw8nElFn3vb5vpizE
         uydS511H3iz5a3WR7+tYF7fxa4oqfnmpxpZQIfZJLMjZO4yZypnr7Hufz4Lvz5BU6U+K
         IYGGCdcnxhyYujcqcebWELne8VdzAglSca+SM8W7xZzrjGmUEdAxjB2FkAiO8/QsRD8e
         C9/Q==
X-Gm-Message-State: AOAM533q5bCvX5KXqEfsChN/a82f4AXDUHsJ5eobR0qgQEm5MOmQPudD
        Na7XMi+NeKl0brXtysNFAHsjuCtLFmI=
X-Google-Smtp-Source: ABdhPJxcXk4SccgK1N4Uudev1dbKVmTOmTYVTUFWP7lAk4ng3Sf5e84hq4MWt3H9bLcmUDv0KhlKUw==
X-Received: by 2002:a63:234e:: with SMTP id u14mr40883pgm.23.1605469889767;
        Sun, 15 Nov 2020 11:51:29 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 26sm13956328pgu.83.2020.11.15.11.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 11:51:29 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, Moritz Fischer <mdf@kernel.org>
Subject: [RESEND PATCH 00/10] Introduce devm_fpga_mgr_register()
Date:   Sun, 15 Nov 2020 11:51:17 -0800
Message-Id: <20201115195127.284487-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
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

 drivers/fpga/altera-pr-ip-core-plat.c | 10 ----
 drivers/fpga/altera-pr-ip-core.c      |  4 +-
 drivers/fpga/altera-ps-spi.c          | 14 +----
 drivers/fpga/dfl-fme-mgr.c            | 13 +----
 drivers/fpga/fpga-mgr.c               | 81 +++++++++++++++++++++++----
 drivers/fpga/ice40-spi.c              | 14 +----
 drivers/fpga/machxo2-spi.c            | 14 +----
 drivers/fpga/socfpga.c                | 14 +----
 drivers/fpga/ts73xx-fpga.c            | 14 +----
 drivers/fpga/xilinx-spi.c             | 14 +----
 drivers/fpga/zynqmp-fpga.c            | 21 +------
 include/linux/fpga/fpga-mgr.h         |  2 +
 12 files changed, 80 insertions(+), 135 deletions(-)

-- 
2.29.2

