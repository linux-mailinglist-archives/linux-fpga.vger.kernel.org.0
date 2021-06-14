Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCB63A6CC6
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Jun 2021 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhFNRL0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Jun 2021 13:11:26 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:39688 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhFNRLZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Jun 2021 13:11:25 -0400
Received: by mail-pg1-f181.google.com with SMTP id w31so6657814pga.6
        for <linux-fpga@vger.kernel.org>; Mon, 14 Jun 2021 10:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zowakluA1+M5mJqoofA+xmDLd8QCdLfvYi9v+aSBqg8=;
        b=lVLKyI3AfaTDUGPf+/IfhZopUExw0SIR0QLy9ZZbnICKXHJElU0TkyPEfPuHPptDCn
         zOs2OubS7ixAh6Mf8G/YSBqbljqSQ7+353UN9YtxvAmOas4bBZmhn7zIUJDera7vPkgk
         /icKVUwJBFypNrcXZInQuPjjhtXI5ntTMzBvvY2pxwdO374Dv00EnjSkCo5/MnI/TSZp
         fHFU/AVMm8TKvH0wLU0+bbQFIQxQ6rHAdrI2crDApCguFfHEP0jphSvgPBZEQlcFKD/+
         6S6lzNlVwzczQuM+2CitmOCRjLe9NmWIgVdnYbjsyCFE+s1J3YeBzcQtzJIsFEAmncMx
         JDQg==
X-Gm-Message-State: AOAM531dYGp3E+LtjoapxIzUZMcufPw5l/j1aq+faVq7irbaGnVLs4Ce
        sarEO5Ut5D6Uu3Re+QD7maQ=
X-Google-Smtp-Source: ABdhPJzcR1a4j+FSWftWcDU2+K6CoCp8wLJDwBa0J/jKHVKYj5xzoqL1xapmi8ySrpT51b9kqNOReQ==
X-Received: by 2002:a63:e64a:: with SMTP id p10mr15204927pgj.424.1623690562481;
        Mon, 14 Jun 2021 10:09:22 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bv3sm420644pjb.1.2021.06.14.10.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:09:21 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/8] FPGA Manager devres cleanup
Date:   Mon, 14 Jun 2021 10:09:01 -0700
Message-Id: <20210614170909.232415-1-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

please consider this series for inclusion into 5.14-rc1.

It attempts to clean up the issues pointed out by you earlier
in https://lore.kernel.org/linux-fpga/YKKuBSLp5Fe0Zh0v@kroah.com

If you prefer I can provide a signed tag instead.

Thanks,

Moritz

Russ Weight (8):
  fpga: altera-pr-ip: Remove function alt_pr_unregister
  fpga: stratix10-soc: Add missing fpga_mgr_free() call
  fpga: mgr: Rename dev to parent for parent device
  fpga: bridge: Rename dev to parent for parent device
  fpga: region: Rename dev to parent for parent device
  fpga: mgr: Use standard dev_release for class driver
  fpga: bridge: Use standard dev_release for class driver
  fpga: region: Use standard dev_release for class driver

 drivers/fpga/altera-pr-ip-core.c       | 10 -----
 drivers/fpga/fpga-bridge.c             | 46 ++++++++++-----------
 drivers/fpga/fpga-mgr.c                | 55 ++++++++++++--------------
 drivers/fpga/fpga-region.c             | 44 ++++++++++-----------
 drivers/fpga/stratix10-soc.c           |  1 +
 include/linux/fpga/altera-pr-ip-core.h |  1 -
 6 files changed, 71 insertions(+), 86 deletions(-)

-- 
2.31.1

