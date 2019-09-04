Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E2A7919
	for <lists+linux-fpga@lfdr.de>; Wed,  4 Sep 2019 05:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfIDDAX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 3 Sep 2019 23:00:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40675 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfIDDAX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 3 Sep 2019 23:00:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so10369383pgj.7
        for <linux-fpga@vger.kernel.org>; Tue, 03 Sep 2019 20:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1BGNdyODZdCjsnVyQ0BMtJqocrDJ7jRW8D43NKZ/+sQ=;
        b=YDhTfJE+Ngxd8QCBFoHf6E2xHqwh3NzTUJiY/73Y8S8jXgD6igQhLoRhRhjiCdlP9I
         YrWpdqswsxQbGTKMyZeEB0XZ52BMJV5ohUfBB4lEAHHAQQXH1vuvDeODyC5rgHX3wimu
         xyqe6Sl81r048tnccGDkkar+thId9/gQxUvOZZ/y2cOr0QwvQ2jB1eUPdcN23nFnq1hd
         Lht+i9NiUY2S+9/pHJkdTXSt2NU+WnXOw4teRgcC2QhjTzg5pzTxhUqcbai2Fw+TvpUW
         wzEyVZLLeYlhDGP7z2bqBcye0XPs60xuVjQRD6prWScGiu9tNSJ9Lyq1L628p41YFU7x
         3mXQ==
X-Gm-Message-State: APjAAAX37+gTNCjrrPHzry/gzV9X4MVBlUjMDy8pV8dBFFVd2RM+Kt19
        xxTFFNQW2yezQAKfsIp2opgJxQ==
X-Google-Smtp-Source: APXvYqxWy42FesjlzNZTKTiAy3vTYgl1PLXw+eezu88hC9xQEymRTClE90MmbMbouyqYuCyOEXwEiw==
X-Received: by 2002:a17:90a:86c3:: with SMTP id y3mr2636842pjv.66.1567566022829;
        Tue, 03 Sep 2019 20:00:22 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id p20sm21184433pgi.81.2019.09.03.20.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 20:00:21 -0700 (PDT)
Date:   Tue, 3 Sep 2019 20:00:20 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     moritzf@google.com, hao.wu@intel.com, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA DFL Changes for 5.4 (late, sorry)
Message-ID: <20190904030020.GA5534@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

not sure I got this one right. It's a bit complicated, since there's
some dependencies on stuff already in char-misc-next as well as the
dev_groups_all_drivers.

Let me know if I messed up.

Thanks,
Moritz

The following changes since commit 99097a214b0c15f7595ac8f2788662f3941c1992:

  Merge 5.3-rc7 into char-misc-next (2019-09-02 19:30:09 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-dfl-for-5.4

for you to fetch changes up to 77a0ef488de9ac6054204c5bf61cf2095fff25d8:

  Documentation: fpga: dfl: add descriptions for virtualization and new interfaces. (2019-09-03 19:35:42 -0700)

----------------------------------------------------------------
FPGA DFL Changes for 5.4

This pull-request contains the FPGA DFL changes for 5.4

- The first three patches are cleanup patches making use of dev_groups and
  making the init callback optional.
- One patch adds userclock sysfs entries that are DFL specific
- One patch exposes AFU port disable/enable functions
- One patch adds error reporting
- One patch adds AFU SignalTap support
- One patch adds FME global error reporting
- The final patch is a documentation patch that decribes the
  virtualization interfaces

This patchset requires the 'dev_groups_all_drivers' tag from drivers
core for the dev_groups refactoring as well as the DFL changes already
in char-misc-next.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Dmitry Torokhov (1):
      driver core: add dev_groups to all drivers

Moritz Fischer (2):
      Merge tag 'dev_groups_all_drivers' into fpga-dfl-for-5.4
      Merge branch 'char-misc-next' of git://git.kernel.org/.../gregkh/char-misc into fpga-dfl-for-5.4

Thor Thayer (3):
      fpga: altera-cvp: Discover Vendor Specific offset
      fpga: altera-cvp: Preparation for V2 parts.
      fpga: altera-cvp: Add Stratix10 (V2) Support

Wu Hao (9):
      fpga: dfl: make init callback optional
      fpga: dfl: fme: convert platform_driver to use dev_groups
      fpga: dfl: afu: convert platform_driver to use dev_groups
      fpga: dfl: afu: add userclock sysfs interfaces.
      fpga: dfl: afu: expose __afu_port_enable/disable function.
      fpga: dfl: afu: add error reporting support.
      fpga: dfl: afu: add STP (SignalTap) support
      fpga: dfl: fme: add global error reporting support
      Documentation: fpga: dfl: add descriptions for virtualization and new interfaces.

 Documentation/ABI/testing/sysfs-platform-dfl-fme  |  62 ++++
 Documentation/ABI/testing/sysfs-platform-dfl-port |  53 ++++
 Documentation/fpga/dfl.rst                        | 105 +++++++
 drivers/base/dd.c                                 |  14 +
 drivers/fpga/Kconfig                              |   6 +-
 drivers/fpga/Makefile                             |   3 +-
 drivers/fpga/altera-cvp.c                         | 339 +++++++++++++++-----
 drivers/fpga/dfl-afu-error.c                      | 230 ++++++++++++++
 drivers/fpga/dfl-afu-main.c                       | 230 +++++++++++---
 drivers/fpga/dfl-afu.h                            |   9 +
 drivers/fpga/dfl-fme-error.c                      | 359 ++++++++++++++++++++++
 drivers/fpga/dfl-fme-main.c                       |  42 +--
 drivers/fpga/dfl-fme.h                            |   3 +
 drivers/fpga/dfl.c                                |  10 +-
 drivers/fpga/dfl.h                                |   9 +
 include/linux/device.h                            |   3 +
 16 files changed, 1329 insertions(+), 148 deletions(-)
 create mode 100644 drivers/fpga/dfl-afu-error.c
 create mode 100644 drivers/fpga/dfl-fme-error.c
