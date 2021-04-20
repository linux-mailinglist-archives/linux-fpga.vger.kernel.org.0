Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A48D365F7F
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Apr 2021 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhDTSgg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Apr 2021 14:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233532AbhDTSgf (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Apr 2021 14:36:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5E88613D0;
        Tue, 20 Apr 2021 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618943763;
        bh=dK943MPZ1IMc++JGvgUyxTvLJTgIj/OVmkNLVW8XDf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G688H9fqU6S/3mOhASPJD8Q3HP/mM8PlSrvvp9CytGpbVOD4ksfpFFweHuqasqfwV
         7Wb3qqc380zMpADcNKpzojWJ9rLZkTd8FS/5jKV/4XKGRoLFqulpEUqlZ4bBdxbta2
         K6MR5dbnz1TZa7INkm4KkedvO22uOnOLyj+91SyKBDlvie7mZYw2BL5NiHHGfOJl5Y
         9k8YRyW+LLBR8uFdh+MgJLiAI8Xyq2fev7whQv8J0BHFFdzeyWNsbuCLFeFD10RT3a
         AErS/YD8hZlvfTYm1F5kke8siLEbZIEfbtV/CT7/5+5JM5pgJq58ajAPSv4J+cR5bz
         ioD/DHSrLNHIw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-spi@vger.kernel.org, russell.h.weight@intel.com,
        linux-kernel@vger.kernel.org, trix@redhat.com, yilun.xu@intel.com,
        linux-fpga@vger.kernel.org, matthew.gerlach@linux.intel.com,
        hao.wu@intel.com
Cc:     Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 0/2] spi: altera: Add DFL bus support for Altera SPI
Date:   Tue, 20 Apr 2021 19:35:30 +0100
Message-Id: <161894372992.35357.14050459219485520194.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210416165720.554144-1-matthew.gerlach@linux.intel.com>
References: <20210416165720.554144-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, 16 Apr 2021 09:57:18 -0700, matthew.gerlach@linux.intel.com wrote:
> This patch set adds Device Feature List (DFL) bus support for
> the Altera SPI Master controller.
> 
> Patch 1 separates spi-altera.c into spi-altera-core.c and
> spi-altera-platform.c.
> 
> Patch 2 adds spi-altera-dfl.c.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: altera: separate core code from platform code
      commit: b0c3d9354de1f87eebc00694d5218b6611265933
[2/2] spi: altera: Add DFL bus driver for Altera API Controller
      commit: ba2fc167e9447596a812e828842d0130ea9cd0e4

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
