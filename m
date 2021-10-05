Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F82422FE3
	for <lists+linux-fpga@lfdr.de>; Tue,  5 Oct 2021 20:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhJESYz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 5 Oct 2021 14:24:55 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:38494 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhJESYy (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 5 Oct 2021 14:24:54 -0400
Received: by mail-pg1-f181.google.com with SMTP id s75so150209pgs.5
        for <linux-fpga@vger.kernel.org>; Tue, 05 Oct 2021 11:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qMeIqI1ZRemrewkdfXEwRzmVQ7pNZYF2tWXUacNz2cI=;
        b=nXkTT5hncWDwhUcwIGUvq2/jC/tH9IxoS1WO3VleEXjDEM/jwdOk2d5RY27ElBFy2G
         uhiZ8diWCqlxvE3trw95syNrrSvsEdQSWlAeCzshBbjRxsM5GNiTPI1UlMFjQyA0KRFC
         b8pWFV2JDgDnzo/CR6doR3uUdWIPd9itK6VM8C91iGkwEyNa0kJj6bNVlA6/L8S8h0ho
         YmnKsfCQr0S0AhLZxW6yjIZ0wPT3MM7JxJ8v3J7LkKehqzfixZYZvbk5Ibhr97UT181R
         adUMB6/geNg202jHIAwHKrDWYAPlGHfkX04Z42F8lj3nmuUL4xXDVbPVTvioXaHd/bAh
         vOJQ==
X-Gm-Message-State: AOAM531yYwH13qWhdet8Dhb2qOjw4yu0bhC5W26nhqpWRs/HxQk1IKKV
        zqwK/fz3nG5NBDywEqDfDLEZ19/MtiHJ7g==
X-Google-Smtp-Source: ABdhPJzc9t0CHMh8WGDZVlKSdutJlZHm0RryHH2LHiRwOLjyvqVGEZrjioZQNY+DbwIMI4vTZcl62Q==
X-Received: by 2002:a65:400c:: with SMTP id f12mr16725219pgp.296.1633458183865;
        Tue, 05 Oct 2021 11:23:03 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id o2sm2866634pja.7.2021.10.05.11.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 11:23:03 -0700 (PDT)
Date:   Tue, 5 Oct 2021 11:23:02 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com,
        moritzf@google.com
Subject: [GIT PULL] FPGA Manager fix for 5.15-rc5
Message-ID: <YVyYBilF18kybSKL@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-fixes-5.15-rc5

for you to fetch changes up to 2a2a79577ddae7d5314b2f57ca86b44d794403d5:

  fpga: ice40-spi: Add SPI device ID table (2021-09-27 14:00:41 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.15

Mark's fix adds a MODULE_DEVICE_TABLE to ensure module autoloading
works for the Lattice ice-40-spi FPGA Manager driver.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Mark Brown (1):
      fpga: ice40-spi: Add SPI device ID table

 drivers/fpga/ice40-spi.c | 7 +++++++
 1 file changed, 7 insertions(+)
