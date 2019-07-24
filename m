Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9AC7273E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Jul 2019 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGXFUP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Jul 2019 01:20:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34808 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfGXFUO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Jul 2019 01:20:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so14355739pgc.1
        for <linux-fpga@vger.kernel.org>; Tue, 23 Jul 2019 22:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=m4QDXoQJCgqv+0KjGs2opKRwM744dByyftRnkLkrxXw=;
        b=OEkb04oCAGSdgMyB31yL8fIgerV+6UIh0J2dcdaxK71sIvwHXRHELg2pyQVrQLIIbE
         72yq6DwDGkcBZSdSHt2ShSGohkJKoWJeTc+n1Ful/ZsOIWk3NXPIRoT90fuHwwxpOt9X
         YwdiDpoTHDCvDTOqfJBQyIWvlRQCOdrjzGw0xIF//gaPkD9r0GYc5dLVpdpioECqP4hl
         ziCcuyVOhVuVcEanhPxLYRtQnN09wGWElgV7CmQQeFEGQDvWvAmlGI3hKspoO2l+eE4y
         stanKRRru9G5jdSv2fiVhJQSTLLa9tZ+ka5+o/+gH7lNIRou/by+LGEO+LYUnq8sy7B5
         aOQg==
X-Gm-Message-State: APjAAAVuJgHOf/6aqAelqbnYumkV33U3igReahQHz6sT3/dYEnTIeKNx
        WNxUJB/98Yjx6qqh3soZJ06V9Q==
X-Google-Smtp-Source: APXvYqz6Gtvl1sx5/K6rd1hMxd5BJOlgR8qiDTZeJH0cbbd+jHWtrTDZTVhnFYTJoy/6J1LHPip6mA==
X-Received: by 2002:a65:5202:: with SMTP id o2mr56746898pgp.29.1563945614134;
        Tue, 23 Jul 2019 22:20:14 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id a6sm39858550pjs.31.2019.07.23.22.20.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 22:20:13 -0700 (PDT)
Date:   Tue, 23 Jul 2019 22:20:12 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: [GIT PULL] FPGA Manager fix for 5.3
Message-ID: <20190724052012.GA3140@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fixes-for-5.3

for you to fetch changes up to c3aefa0b8f54e8c7967191e546a11019bc060fe6:

  fpga-manager: altera-ps-spi: Fix build error (2019-07-23 17:29:17 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

Hi Greg,

this is only one (late) bugfix for 5.3 that fixes a build error,
when altera-ps-spi is built as builtin while a dependency is built as a
module.

This has been on the list for a while and I've reviewed it.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
YueHaibing (1):
      fpga-manager: altera-ps-spi: Fix build error

 drivers/fpga/Kconfig | 1 +
 1 file changed, 1 insertion(+)
