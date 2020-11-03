Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98352A3D77
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgKCHVT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Nov 2020 02:21:19 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36538 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgKCHVT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Nov 2020 02:21:19 -0500
Received: by mail-pg1-f169.google.com with SMTP id z24so12999428pgk.3
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 23:21:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y+GzckxBjUxDDBxm8cL8XufVT4XIIN/nfBAgvA5sj38=;
        b=n0L/BvbtHzKZfL9D/yDiIHW5aeHzuXrKN1uiZvaaroKsrLRQxcSbxz9iVKnky28Yeh
         Ahg4CTipizdTT7WzPptP6StkOvthQknfRi7N1yMBhANXqINwO4tU1TjTJjqPWjQppOve
         NC4j+1xMqGrWiXQa73tv+K+Q/VwiTmyBeUnMF77s1GJtVkC3MpSe+OjFB9ruCdxhaGVD
         GtSCFnnwUOnD6g3Ot6vvZVbivwnJlIVFKQRciCwZ8j8q0tPKQxCJarc/5S1qihlafnXq
         ISqMUwsWDITK7LR+H4vCJr3mJe++pDdq7wWwRzU3KKdLRz05b50gL9hj1jwE97+4CtMF
         Fusw==
X-Gm-Message-State: AOAM532ctBMJyK6ug0rOf6/6+Vrwkkbu24XUp1lwO2q2TtWM3WRlCSry
        EEk2X++q8NOycW2FuO2I99U=
X-Google-Smtp-Source: ABdhPJwpAwqFRvV8mGcfXp84/vMTWywv9AWf4uu2kBr6MajtHLeozNHapIGzwJrSjGt10jRDOIJtng==
X-Received: by 2002:a62:8cc1:0:b029:18b:32bf:8e29 with SMTP id m184-20020a628cc10000b029018b32bf8e29mr2794149pfd.42.1604388078293;
        Mon, 02 Nov 2020 23:21:18 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id x26sm16140115pfn.178.2020.11.02.23.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 23:21:17 -0800 (PST)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 0/4] DFL Module support
Date:   Mon,  2 Nov 2020 23:21:00 -0800
Message-Id: <20201103072104.12361-1-mdf@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

as requested resend of pull request as patches.

Note: I put this on a separate branch so Maintainers can pull the stable
tag to allow them to apply DFL based drivers through their trees
(krzk@ had asked for this when Xu intially posted his patchset, since
there was a driver for drivers/memory that uses this series).

Thanks,

Moritz

Xu Yilun (4):
  fpga: dfl: fix the definitions of type & feature_id for dfl devices
  fpga: dfl: move dfl_device_id to mod_devicetable.h
  fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h

 MAINTAINERS                       |  1 +
 drivers/fpga/dfl.c                |  4 +-
 drivers/fpga/dfl.h                | 85 +-----------------------------
 include/linux/dfl.h               | 86 +++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h   | 24 +++++++++
 scripts/mod/devicetable-offsets.c |  4 ++
 scripts/mod/file2alias.c          | 13 +++++
 7 files changed, 131 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/dfl.h

-- 
2.29.2

