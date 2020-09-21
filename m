Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88DEE2718BA
	for <lists+linux-fpga@lfdr.de>; Mon, 21 Sep 2020 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIUAI5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 20 Sep 2020 20:08:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34812 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIUAI5 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 20 Sep 2020 20:08:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id u13so7399443pgh.1
        for <linux-fpga@vger.kernel.org>; Sun, 20 Sep 2020 17:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9S6F1JNFtYnR5rnqwZHh7bJvCrIJjCvA2ZBGcWrRQlM=;
        b=c8jj+cEBdCFLMvZTBH/iTQUWY08DcSZE2V6Pr60zA3p8xfIpA924OxgrTEJJKKdvgk
         /bcp71FFYXvqbQotRd2TIeMfovf3OHgUKhn/HhR8v4TSNtL5Lsy3Bp+kZWdBcRAX6yEH
         uOw3TDv/9tUD9Sn1dMRH7t/Ugox/zHShKYSP+ybRPqwaAhK5mLP4R/S7NnEgYK73Yypr
         ZJMCPz/eliJKMKQ9kUvQt8mPoRmQBkTzvPluBCxyzt5+KTAEeU2FrXlpXwRtY/WcjOwY
         dNvYfci++6CWD1Xa4qSdeKzZieFPZznCZvsSUC96gTS1zjOV/3GmFUFhBriQ7pVNooZl
         mPQg==
X-Gm-Message-State: AOAM531uOLkdQXvKN2vlENqy5QCe8AdJiCMR7V8JoofByD1JZ7oCiEOI
        jcO2tY3QdB9dJ7CSmYPcdhI=
X-Google-Smtp-Source: ABdhPJxtx/rpKTgY/eKqte0yeI0XpBfKUgtW7ohRhPoAM6QvTwchhfi7wFN9wTv3gCyfZlxiP2p9OA==
X-Received: by 2002:a05:6a00:1585:b029:142:2501:35ed with SMTP id u5-20020a056a001585b0290142250135edmr25836899pfk.77.1600646936613;
        Sun, 20 Sep 2020 17:08:56 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id f18sm10994920pfe.153.2020.09.20.17.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 17:08:55 -0700 (PDT)
Date:   Sun, 20 Sep 2020 17:08:55 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager additional changes for 5.10
Message-ID: <20200921000855.GA15612@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 9ba3a0aa09fe505540a3bdd11f0da3b8e9d73055:

  fpga: dfl: create a dfl bus type to support DFL devices (2020-09-09 20:28:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-extra-for-5.10

for you to fetch changes up to 41b9b36fe986e15eba0a4220c18d72fa5eb9f0dd:

  fpga: dfl: n3000-nios: Make m10_n3000_info static (2020-09-16 19:16:58 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.10-rc1

Here is the second set of FPGA changes for the 5.10 merge window.

Mircea's changes are part of a changeset to add support for FPGA based
clock drivers.

My change fixed a whitespace error in that patch that I missed when
initially applying it.

Xu's changes contain additional changes to support the new DFL bus,
including some clean ups, refactoring as well as its first user, the
NIOS 3000 driver.

YueHaibing's change addresses a sparse warning.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Mircea Caprioru (1):
      include: fpga: adi-axi-common.h: add definitions for supported FPGAs

Moritz Fischer (1):
      include: fpga: adi-axi-common: Fix leading whitespace in header

Xu Yilun (5):
      fpga: dfl: move dfl_device_id to mod_devicetable.h
      dfl: add dfl bus support to MODULE_DEVICE_TABLE()
      fpga: dfl: fix the comments of type & feature_id fields
      fpga: dfl: add support for N3000 Nios private feature
      fpga: dfl: move dfl bus related APIs to include/linux/fpga/dfl.h

YueHaibing (1):
      fpga: dfl: n3000-nios: Make m10_n3000_info static

 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  49 ++
 Documentation/fpga/dfl-n3000-nios.rst              |  73 +++
 Documentation/fpga/index.rst                       |   1 +
 MAINTAINERS                                        |   3 +-
 drivers/fpga/Kconfig                               |  11 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 573 +++++++++++++++++++++
 drivers/fpga/dfl.c                                 |   1 +
 drivers/fpga/dfl.h                                 |  85 +--
 include/linux/fpga/adi-axi-common.h                | 103 ++++
 include/linux/fpga/dfl.h                           |  86 ++++
 include/linux/mod_devicetable.h                    |  12 +
 scripts/mod/devicetable-offsets.c                  |   4 +
 scripts/mod/file2alias.c                           |  17 +
 14 files changed, 935 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c
 create mode 100644 include/linux/fpga/dfl.h
