Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E902A3A0A
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Nov 2020 02:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKCBub (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Nov 2020 20:50:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44227 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgKCBub (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 2 Nov 2020 20:50:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id 133so12812139pfx.11
        for <linux-fpga@vger.kernel.org>; Mon, 02 Nov 2020 17:50:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TRa7BOpehzmKD7fek9hwEn1KqDsIMGw0sSE4mb0gZn8=;
        b=AxncDAFLpV8lou6aAdOs8K+wTmRHAalOzAZvwH/VCNrkoqerkWbWXeZMzaJ9lYZ0Sw
         /SiGtCp0A6QwRvtFxy18t9LnA3MQNvOSpMqVN1/OL3LNvlxawRz4tAsB0F37xaDd+Cm8
         cCu49DKbkQyxx2ilNsdSCKhXxPPfQUrzQf+BWp2L0UvXUjzlF0WthKfKJlSjlZqLIDRe
         +P8PDgychekfsBJykJZbnv1C0kfrAgcO/bkHttf6bXD3SDk7Zx2Kg4UOVnxBba/8p6c7
         +hFzNY4UHMOszKh0k1aPOtwH3QJ3bKpe9ry/I0QXbbT6DI7DAIqBsByca09OTMk9yxL0
         3Chw==
X-Gm-Message-State: AOAM5330F+lFpZ8IVaaLg6Ab4FraxHRP20g3XXemjTjQpM6Hu81FIkjc
        kVpdnvcha2u77Cf5ebqFaunb0L1fuJU=
X-Google-Smtp-Source: ABdhPJx+8LOV2tV3FTGqGBnzbIneP9LEDbdrwMIzAksOpId4pclVDYbrKXRf9BUSYsxu0233E5fiWw==
X-Received: by 2002:a05:6a00:148a:b029:18b:1ce6:4741 with SMTP id v10-20020a056a00148ab029018b1ce64741mr3539830pfu.49.1604368230736;
        Mon, 02 Nov 2020 17:50:30 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z10sm14999338pff.218.2020.11.02.17.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 17:50:30 -0800 (PST)
Date:   Mon, 2 Nov 2020 17:50:28 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.com
Subject: [GIT PULL] FPGA DFL Modularization changes for 5.11
Message-ID: <20201103015028.GA3548@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/dfl-modularization-for-5.11

for you to fetch changes up to b816f126cfe5842fa21f49ff851c357497c38d5a:

  fpga: dfl: move dfl bus related APIs to include/linux/dfl.h (2020-10-26 10:13:24 -0700)

----------------------------------------------------------------
First set of DFL changes for 5.11-rc1 merge window

These are on a separate branch to enable other Maintainers to pull this
tag to allow for taking DFL patches through their trees.

Modularization
- Xu's changes add the functionality to add DFL devices
  on the DFL bus as separate modules.

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Xu Yilun (4):
      fpga: dfl: fix the definitions of type & feature_id for dfl devices
      fpga: dfl: move dfl_device_id to mod_devicetable.h
      fpga: dfl: add dfl bus support to MODULE_DEVICE_TABLE()
      fpga: dfl: move dfl bus related APIs to include/linux/dfl.h

 MAINTAINERS                       |  1 +
 drivers/fpga/dfl.c                |  4 +-
 drivers/fpga/dfl.h                | 85 +-------------------------------------
 include/linux/dfl.h               | 86 +++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h   | 24 +++++++++++
 scripts/mod/devicetable-offsets.c |  4 ++
 scripts/mod/file2alias.c          | 13 ++++++
 7 files changed, 131 insertions(+), 86 deletions(-)
 create mode 100644 include/linux/dfl.h
