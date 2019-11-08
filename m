Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC77F50E9
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Nov 2019 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfKHQTd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 8 Nov 2019 11:19:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38169 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfKHQTd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 8 Nov 2019 11:19:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id c13so4908189pfp.5
        for <linux-fpga@vger.kernel.org>; Fri, 08 Nov 2019 08:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C3GyqPeAOJqUFP9+9khiMSLvDXDJZJcvSutGngbBuxE=;
        b=jPHjFfLax743PF2Z0kqQ64yAGLYAYjsTOLT8yKkF1wC9qN9WfGsb2oCaqZuR+tVdxt
         qvfKLajPtqqiVMXKLJ0yH3HIbonpr89/LcLRvV/hibUITckEmyO8DFpGpZ4TTua2koKU
         bsXAQ75IQOYK25/JSa6CMJqVWtajgrzjGstzVhsvZyM5icnapX9qrF6LN6QrlSBukBJP
         r+R81MaQ5B8Sid68SKnQlygjbxCZjWrOXCXaPHb1zRHga6VFHzmWM7yFdZRHug7reGom
         xc1klG+72uJBQICvb87hFaH3tEDPrXegaVPEP/UsloJrkSUw/hfpxJHqyx9zUCdADIOW
         1VZA==
X-Gm-Message-State: APjAAAWJ1BblM6Nh/a73npkFI6tA77bTiHB2JHCjz/MGO7h3C0pTmWhy
        4EnLyYeXnvrbukUvuOJJrAI=
X-Google-Smtp-Source: APXvYqyUk8/n+97SxxEqydBCMqAKczLQzL7eQGnxOUiiVMiRRAnIBSgDrhKuItTcGzSrHAPOdLkB/Q==
X-Received: by 2002:a62:7c91:: with SMTP id x139mr12412720pfc.119.1573229972463;
        Fri, 08 Nov 2019 08:19:32 -0800 (PST)
Received: from localhost (c-73-15-170-202.hsd1.ca.comcast.net. [73.15.170.202])
        by smtp.gmail.com with ESMTPSA id f15sm6919695pfd.141.2019.11.08.08.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:19:31 -0800 (PST)
Date:   Fri, 8 Nov 2019 08:19:30 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, hao.wu@intel.com, moritzf@google.com
Subject: [GIT PULL] FPGA changes for 5.5
Message-ID: <20191108161808.GA398122@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-dfl-for-5.5

for you to fetch changes up to fddc9fcbe69a502d84adf0bad5e2c6c80823838c:

  fpga: dfl: fme: add power management support (2019-10-16 19:18:27 -0700)

----------------------------------------------------------------
Here is the first set of FPGA changes for 5.5

The first patch from Stephen is a trivial cleanup patch.

The following three patches add hwmon support to DFL FPGAs.

All of this patches have been reviewed and been in the last couple
of linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Stephen Boyd (1):
      fpga: Remove dev_err() usage after platform_get_irq()

Wu Hao (2):
      fpga: dfl: fme: add thermal management support
      fpga: dfl: fme: add power management support

Xu Yilun (1):
      Documentation: fpga: dfl: add descriptions for thermal/power management interfaces

 Documentation/ABI/testing/sysfs-platform-dfl-fme | 132 ++++++++
 Documentation/fpga/dfl.rst                       |  10 +
 drivers/fpga/Kconfig                             |   2 +-
 drivers/fpga/dfl-fme-main.c                      | 385 +++++++++++++++++++++++
 drivers/fpga/zynq-fpga.c                         |   4 +-
 5 files changed, 529 insertions(+), 4 deletions(-)
