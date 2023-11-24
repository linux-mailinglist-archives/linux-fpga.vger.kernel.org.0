Return-Path: <linux-fpga+bounces-44-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC037F78E8
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 17:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AF21C2090E
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Nov 2023 16:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16E2E85A;
	Fri, 24 Nov 2023 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFsGYBmE"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1247D56
	for <linux-fpga@vger.kernel.org>; Fri, 24 Nov 2023 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700843306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DMuuKTowyPDws4BIecBU/jtUc+x5ojc5dQmrhzizeMw=;
	b=bFsGYBmE+pRq0Rakrwt/sk5KKtMohr7AwqTj5PCEWt6efsoiwd4PQ3DZWMna0NILt9fg6a
	s1JGXugXcWfJKdWte4vnFpC6uLuf9Wu7Bkp20PrmHRmg+V7+8a7Lbav0syftUGgTc/xCjK
	1mKCDcRc1JkXsjyEuHTcE6WMSVdLb1Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-GouSNdrcNAyaInLeZNJ0Cw-1; Fri, 24 Nov 2023 11:28:24 -0500
X-MC-Unique: GouSNdrcNAyaInLeZNJ0Cw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-77893b0a2cdso228049685a.2
        for <linux-fpga@vger.kernel.org>; Fri, 24 Nov 2023 08:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700843304; x=1701448104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMuuKTowyPDws4BIecBU/jtUc+x5ojc5dQmrhzizeMw=;
        b=fdJTiLKVhneJLHt6J7u0M+/7yMq/4GRxFHrA4ornx4hoIIh/I/r2GKV9Q+o1wR2due
         9pHAT/u82DqEYkYkae/kC+wL4i4rnVRW5h46FTnePXNa+rPM/zd9uW1SZf/WkY8EEWRp
         XLmp+qB5sJj4YUBTVK7E21ETvx1UHjFB5u2kRI5Kq0wrQxHgVjogWCxX74RqPSGFizek
         lPUu0uaVPaXPU73StfmyqHq3WEl61UzwPORoGxXSlYVC2Zz4jaAJP62jh9deX0WzbmEa
         S5N3dPPkGxzOGuP5SzPIaOxCP69rLAQJ3P5BAEoeoDTl0pYHGxGp5jZtGpWWhexvgV5B
         f4vA==
X-Gm-Message-State: AOJu0YwzTyZPyS4kMvmXjgJIiMyn+sKd4UBU1zzUqgT0DEfHUvuuMDbB
	zUJBA8FEkyx1aolp6keiqCfazsNzf1B/RDq56O3aFkcPm4JLQnFNn6aceDCSiB+Iu+LHPIzvBtc
	HED/fL4udrW9EwWwJblN7
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr2960041qkn.14.1700843304036;
        Fri, 24 Nov 2023 08:28:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENvtRHrxOOH3LXMpZWWpNvzpDXaRq7vmDCk78z2mTT02BXioTGM6LwGddIXH2SrlpwvsPj9g==
X-Received: by 2002:a05:620a:1daa:b0:779:deb9:72c6 with SMTP id pj42-20020a05620a1daa00b00779deb972c6mr2960030qkn.14.1700843303833;
        Fri, 24 Nov 2023 08:28:23 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-24-178.cust.vodafonedsl.it. [2.34.24.178])
        by smtp.gmail.com with ESMTPSA id rk4-20020a05620a900400b007676f3859fasm1327608qkn.30.2023.11.24.08.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 08:28:23 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v2 0/2] fpga: improve protection against low-level modules unloading
Date: Fri, 24 Nov 2023 17:28:05 +0100
Message-ID: <20231124162807.238724-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a possible solution to keep protecting the fpga
manager against the sudden unloading of low-level control modules while
addressing the limitations of the current implementation. Currently, the
code assumes that the low-level module registers a platform driver for
the parent device, which can later be used by the fpga manager (through
the parent device pointer) to take the low-level module's refcount. This
proposal removes this limitation by adding a module owner field to the
fpga_manager and fpga_manager_ops structs. Low-level control modules can
statically set the owner field to THIS_MODULE. Later, the fpga manager
can use the owner field to take the module's refcount.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

v2:
- Fixed protection against races during module removal

Marco Pagani (2):
  fpga: add a module owner field to fpga_manager and fpga_manager_ops
  fpga: set owner of fpga_manager_ops for existing low-level modules

 drivers/fpga/altera-cvp.c             |  1 +
 drivers/fpga/altera-pr-ip-core.c      |  1 +
 drivers/fpga/altera-ps-spi.c          |  1 +
 drivers/fpga/dfl-fme-mgr.c            |  1 +
 drivers/fpga/fpga-mgr.c               | 56 +++++++++++++++++++--------
 drivers/fpga/ice40-spi.c              |  1 +
 drivers/fpga/lattice-sysconfig.c      |  1 +
 drivers/fpga/machxo2-spi.c            |  1 +
 drivers/fpga/microchip-spi.c          |  1 +
 drivers/fpga/socfpga-a10.c            |  1 +
 drivers/fpga/socfpga.c                |  1 +
 drivers/fpga/stratix10-soc.c          |  1 +
 drivers/fpga/tests/fpga-mgr-test.c    |  1 +
 drivers/fpga/tests/fpga-region-test.c |  1 +
 drivers/fpga/ts73xx-fpga.c            |  1 +
 drivers/fpga/versal-fpga.c            |  1 +
 drivers/fpga/xilinx-spi.c             |  1 +
 drivers/fpga/zynq-fpga.c              |  1 +
 drivers/fpga/zynqmp-fpga.c            |  1 +
 include/linux/fpga/fpga-mgr.h         |  4 ++
 20 files changed, 62 insertions(+), 16 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.42.0


