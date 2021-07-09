Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C093C2928
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGISsM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 14:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229841AbhGISsJ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 14:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625856325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CkQ/xgleYsDFkubWHrN4e919svBSGwuji89qB5UEP34=;
        b=a+UUQEQ5olxThbX8+aPH7MrFbSBtQ9PDz+55nj/7+KOOwhzqZRPZcma4hkdmoyFQoeUA25
        REZ/+wWzhRGaafL6eRXYanQ2pNsEBJ4VneulgOuk+n4dAye57AiHGizgQ+ViiT9vcPZtDK
        j5WbFkK53LWYzRVGPvvpSG6hYvVhh8w=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-2btRc8TDPoKmgDOhJypJmQ-1; Fri, 09 Jul 2021 14:45:22 -0400
X-MC-Unique: 2btRc8TDPoKmgDOhJypJmQ-1
Received: by mail-oi1-f198.google.com with SMTP id l4-20020aca57040000b0290240a9d123c6so7300749oib.0
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 11:45:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CkQ/xgleYsDFkubWHrN4e919svBSGwuji89qB5UEP34=;
        b=ByQdAbosaeEUvkoKWnu5ncsTp1EkLKurYYqoRKgo3h1jIuDR/kGliujOsCOn6lEbtt
         Hn6WJZ8oCZK1mZPa5PrK168os9Oo6/IDO7g6Kw7DZ7S4XkCY2Hftj4BFkjiThtfDSRn4
         nPbWZAso4T93P1WxCmmTQbiZK8t3U/FFPEstwA/jExELHESp3MLiMen6kNpa3IGn87Cm
         uHE8GjEdrCsnCry2djAfSJFifOOfqOzF27J7AMcOumDU7WDNjeCbVhtABupFgaktKMY0
         sCXYlk1Mfh+fVfrKjs1PRhDVCYF2dLMDdD+y4YPHQGlwBu2Whv7tfqqrn+XEP2BPGT5P
         aBig==
X-Gm-Message-State: AOAM532dkAMRFJRO/kspLlcjwoG5jJzDjc9znexITP3OQNtEeOkdam28
        YUIHu4xPomBsu4Mv4JYqgpAd+zU22S3sUENa0Fop3pa6Tyes1Qe/qMwJDDKMK6ugyRxCE8sexf/
        in+DKXlXlitC4iHRw1/SFng==
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr14844064oti.113.1625856321559;
        Fri, 09 Jul 2021 11:45:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJZpkbwDOTwYT4b0ycbPElhmYn2D/4YdqvPwZhQgKsQLL7Dr7wEwHkiaW8LfQyHIBifZmLVA==
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr14844049oti.113.1625856321296;
        Fri, 09 Jul 2021 11:45:21 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a44sm1145482ooj.12.2021.07.09.11.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:45:20 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [RFC PATCH v10 0/3] standard release after compat_id change
Date:   Fri,  9 Jul 2021 11:45:07 -0700
Message-Id: <20210709184511.2521508-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

My objection to 'fpga: Use standard class dev_release function' here
https://lore.kernel.org/linux-fpga/20210709004206.244607-1-russell.h.weight@intel.com/
Is that it has 2 register functions for mgr and region.
This is caused by compat_id data being stored at the wrong level.

By first moving the compat_id data to the implementation level.
'fpga: remove compat_id from fpga_manager and fpga_region'
https://lore.kernel.org/linux-fpga/20210709134229.2510349-6-trix@redhat.com/
2 registers are not needed.

This change removes the register_full()'s as well as the info structs.

Tested on dfl/n3000

Russ Weight (3):
  fpga: mgr: Use standard dev_release for class driver
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 Documentation/driver-api/fpga/fpga-bridge.rst |  12 +-
 Documentation/driver-api/fpga/fpga-mgr.rst    |  23 ++-
 Documentation/driver-api/fpga/fpga-region.rst |   4 -
 drivers/fpga/altera-cvp.c                     |  12 +-
 drivers/fpga/altera-fpga2sdram.c              |  12 +-
 drivers/fpga/altera-freeze-bridge.c           |  10 +-
 drivers/fpga/altera-hps2fpga.c                |  12 +-
 drivers/fpga/altera-pr-ip-core.c              |   7 +-
 drivers/fpga/altera-ps-spi.c                  |   9 +-
 drivers/fpga/dfl-fme-br.c                     |  10 +-
 drivers/fpga/dfl-fme-mgr.c                    |  10 +-
 drivers/fpga/dfl-fme-region.c                 |   7 +-
 drivers/fpga/dfl.c                            |  12 +-
 drivers/fpga/fpga-bridge.c                    | 122 +++----------
 drivers/fpga/fpga-mgr.c                       | 166 +++++-------------
 drivers/fpga/fpga-region.c                    | 108 +++---------
 drivers/fpga/ice40-spi.c                      |   9 +-
 drivers/fpga/machxo2-spi.c                    |   9 +-
 drivers/fpga/of-fpga-region.c                 |  10 +-
 drivers/fpga/socfpga-a10.c                    |  16 +-
 drivers/fpga/socfpga.c                        |   9 +-
 drivers/fpga/stratix10-soc.c                  |  16 +-
 drivers/fpga/ts73xx-fpga.c                    |   9 +-
 drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
 drivers/fpga/xilinx-spi.c                     |  11 +-
 drivers/fpga/zynq-fpga.c                      |  16 +-
 drivers/fpga/zynqmp-fpga.c                    |   9 +-
 include/linux/fpga/fpga-bridge.h              |  30 +++-
 include/linux/fpga/fpga-mgr.h                 |  16 +-
 include/linux/fpga/fpga-region.h              |  12 +-
 30 files changed, 226 insertions(+), 499 deletions(-)

-- 
2.26.3

