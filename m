Return-Path: <linux-fpga+bounces-57-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F320817BD3
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 21:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D331F245E4
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Dec 2023 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAFC72079;
	Mon, 18 Dec 2023 20:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcRtlIzl"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A47204D
	for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 20:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702931296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cesTf4BMIhSFr8qWWmn/Rq34XyOQvunDu3wB6pOXvHw=;
	b=HcRtlIzlbWP3bvbiYrV9VvdR6HIfOIq2FcqZfV2PPmock5m0tSN1nMNJm0jvNw3W4I5pp5
	Rp2waSlhsT+yycOIwuSt50b6TOWqF1lmwNqHUcSHN33V3ogcgOXCMuwviuQmaNkj4e0rGT
	IfmhbL6uvIDm3Is5iW5RvDx53sqs3sI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-qWffgJydNyawOO4e89XUlw-1; Mon, 18 Dec 2023 15:28:15 -0500
X-MC-Unique: qWffgJydNyawOO4e89XUlw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40c38ae9764so30793715e9.1
        for <linux-fpga@vger.kernel.org>; Mon, 18 Dec 2023 12:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702931294; x=1703536094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cesTf4BMIhSFr8qWWmn/Rq34XyOQvunDu3wB6pOXvHw=;
        b=TnYDrPR6qxLAM0bpNjQjUTTRNpHJPEG57NziyCeu6OzF4p2KAp+/eV7A+Q0HZIu0rn
         KM85ewVbn5CyaSBHkIjeZRV5i2oaYhFtM/us4QWgrdnM75L53x9vwX/+eId6Nw4AsfSC
         pvUT3zpBauyV+4ODbH78dfZAoxyzUGTFWw3eLMPW9yEnmxItd6BDum3Hs4TQchQJEXT0
         LrKxNuGNTK28Z2AtSIP7QrR0AQEuvWv9QuLHhcxG28ju3B5t0SgFlL8qVp1NvxUIsxr1
         FMEG4el3+2dylUFShbxQrJrPZd3HMN2G4c4SeIMGdWPv8XLHzCqzwNlXinySKowkBfKP
         vmHA==
X-Gm-Message-State: AOJu0Yy7WiOqYbVU8DWhL0LkadSCNNYbOw+0qIuxNOjzWUfeL9v2DVUW
	9jiyf+55wxAfjq1AcDs2XTBAIB9sa/YY91TRrPbAVKk9JXDTthzalsaZcS9LH0mBlqJozHug9p1
	mnZFQSyYi3LT1boW9CZCF
X-Received: by 2002:a05:600c:1c1c:b0:40c:32d5:18e1 with SMTP id j28-20020a05600c1c1c00b0040c32d518e1mr8332906wms.179.1702931294154;
        Mon, 18 Dec 2023 12:28:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6ec5EYY/6aWAm2029ISx6dkf0RMaL8LL7UCp0W1Mtr4zTo0VLXttxyDeckrux+9/ucUQtzQ==
X-Received: by 2002:a05:600c:1c1c:b0:40c:32d5:18e1 with SMTP id j28-20020a05600c1c1c00b0040c32d518e1mr8332896wms.179.1702931293828;
        Mon, 18 Dec 2023 12:28:13 -0800 (PST)
Received: from klayman.redhat.com (net-2-34-31-72.cust.vodafonedsl.it. [2.34.31.72])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b0040d1450ca7esm9487652wms.7.2023.12.18.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 12:28:13 -0800 (PST)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: [RFC PATCH v3 0/2] fpga: improve protection against low-level control module unloading 
Date: Mon, 18 Dec 2023 21:28:07 +0100
Message-ID: <20231218202809.84253-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC proposes a solution to keep protecting the fpga manager against
the unloading of the low-level control modules while addressing the
limitations of the current implementation. Currently, the code assumes
that the low-level module registers a platform driver for the parent
device that is later used by the fpga manager (through the parent
device's driver pointer) to take the low-level module's refcount. This
proposal removes this limitation by adding a module owner field to the
fpga_manager_ops struct. Low-level control modules can statically set
the owner field to THIS_MODULE, and the fpga manager can later use it to
take the low-level module's refcount.

For more context, please refer to these threads:
https://lore.kernel.org/linux-fpga/ZS6hhlvjUcqyv8zL@yilunxu-OptiPlex-7050
https://lore.kernel.org/linux-fpga/ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050

v3:
- Improved locking using Yilun's proposal
v2:
- Fixed protection against races during module removal

Marco Pagani (2):
  fpga: add an owner field and use it to take the low-level module's
    refcount
  fpga: set owner of fpga_manager_ops for existing low-level modules

 drivers/fpga/altera-cvp.c             |  1 +
 drivers/fpga/altera-pr-ip-core.c      |  1 +
 drivers/fpga/altera-ps-spi.c          |  1 +
 drivers/fpga/dfl-fme-mgr.c            |  1 +
 drivers/fpga/fpga-mgr.c               | 50 ++++++++++++++++++---------
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
 include/linux/fpga/fpga-mgr.h         |  4 +++
 20 files changed, 56 insertions(+), 16 deletions(-)


base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
-- 
2.43.0


