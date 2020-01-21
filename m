Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378CB143521
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jan 2020 02:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAUBWv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 20 Jan 2020 20:22:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40181 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgAUBWv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 20 Jan 2020 20:22:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id s21so581599plr.7
        for <linux-fpga@vger.kernel.org>; Mon, 20 Jan 2020 17:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=j14RfZubFt/ADYoktkqfF3kqrvcp6LUMplRAcaUU7dE=;
        b=JiD/6Euza/4BwfcGFzBiRPAxpEY1xSIG6UkqqMRkfl1st/nNec8Qmoo6aarGp8QI24
         X46SoTEybqlyXC+eHpc72+h69M0LKT7H0zm0e1z1ojkLsv7UxI133AQI3nZmm1/yfj6R
         bZknJ6lYhjp7Pr4ocdKm50oblD3eHDXvUbgli5r/peg1RiiWXjjhJX0vpcCXZ4c6YawW
         m+VMB7i84iIp5s7g/pla0qOgqVIxNfG37svabsSPjUeKzHwPw0v1Xe4sAHo6gNvT56T2
         ahsVrBj0Uni/a91haoYO4xp2Nvn7KQbciSDxDebQO8UZfUFoKf66pddWomXmQur49p3o
         hHCA==
X-Gm-Message-State: APjAAAVpbZ1GGNb0MYV6xVxOUYCvVvqFbVRN00t4i8iQOG63lyzEcZQU
        vLsQa+hk1x4ZJhGQxcsbdPo=
X-Google-Smtp-Source: APXvYqzY4euUa4HCw3pvlKZYnFvhuGI4//NFDr6bffohENvIyPUksDyurY+xH/wElvLQyv5atqtYWw==
X-Received: by 2002:a17:902:b781:: with SMTP id e1mr2843256pls.128.1579569769989;
        Mon, 20 Jan 2020 17:22:49 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:ffa7:88dc:9c39:76d9])
        by smtp.gmail.com with ESMTPSA id j38sm38829147pgj.27.2020.01.20.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 17:22:49 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:22:48 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA changes for 5.6
Message-ID: <20200121012248.GA3890@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-for-5.6

for you to fetch changes up to 28910cee898c2a43fcdd8c26e1378ae8084a93a0:

  fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer (2020-01-10 12:51:56 -0800)

----------------------------------------------------------------
Here is the first set of FPGA changes for 5.6

The first two patches are minor cleanups to the DFL drivers,
that remove unused warnings.

The third patch removes a redundant error message to the ts73xx driver.

The last patch removes a confusing print in case a call to devm_clk_get
returns -EPROBE_DEFER.

All patches have been reviewed on the mailing list and have been in the
last couple of linux-next releases without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Ding Xiang (1):
      fpga: remove redundant dev_err message

Shubhrajyoti Datta (1):
      fpga: xilinx-pr-decoupler: Remove clk_get error message for probe defer

yu kuai (2):
      fpga: dfl: fme: remove set but not used variable 'fme'
      fpga: dfl: afu: remove set but not used variable 'afu'

 drivers/fpga/dfl-afu-main.c        | 2 --
 drivers/fpga/dfl-fme-main.c        | 2 --
 drivers/fpga/ts73xx-fpga.c         | 4 +---
 drivers/fpga/xilinx-pr-decoupler.c | 3 ++-
 4 files changed, 3 insertions(+), 8 deletions(-)
