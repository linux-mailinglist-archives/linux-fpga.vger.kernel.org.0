Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6091A86
	for <lists+linux-fpga@lfdr.de>; Mon, 19 Aug 2019 02:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHSArr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 18 Aug 2019 20:47:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46006 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfHSArr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 18 Aug 2019 20:47:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id w26so102590pfq.12
        for <linux-fpga@vger.kernel.org>; Sun, 18 Aug 2019 17:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0ucN8dYY5G9i42DmmhmlfEYMDNGfWkl/1N/uulaX63U=;
        b=tbmi07e56axffVhqAXnGFVArpcDc6z1j3/p/YeFv0Viho0vtruqX8rDhBlxSvP6CzO
         2tSAh7AFNXYel2rl/wFTwzAeHg0IPHvbD+VLUXKP010Swt6w1u1f5+EYPGlnibKXe6kO
         QB9bZ0tKZy2m6DpdVRYem7I/Vpa07ZlFbzeAdOq2jHl+inWi0FFANoIpUaq5gmRHFrLg
         b899h1eWwwpv2/veyblXYpP4/Y8V4wO16ce8gn8YiWRgHyRrnbq8PMaEg35LTNL3slyL
         984ZndIOzWaPO9l+IFmSRqyXgdSUP9jHwwKGa6zq/ngeIOrmHWmb9/UrIvOdhqvTbBj9
         zzCg==
X-Gm-Message-State: APjAAAXotd7evkliCkbIn6u8UeHmg+8l3R/24AezbW9h2VkEzKFr/5Un
        yqCS0A6MZxGQ+BZ0p6wXc+rrAA==
X-Google-Smtp-Source: APXvYqxMs72RnwgANqr3dH5Y1saPOVPhoQD5u0UW/JUzUOvCIYa+ZK8lo+IMPiTgIZeWq7k/640c4A==
X-Received: by 2002:a63:2043:: with SMTP id r3mr17661312pgm.311.1566175666535;
        Sun, 18 Aug 2019 17:47:46 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id b5sm13488960pfo.149.2019.08.18.17.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 17:47:45 -0700 (PDT)
Date:   Sun, 18 Aug 2019 17:47:44 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager (late) change for 5.3-rc6
Message-ID: <20190819004744.GA20155@archbox>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-fixes-for-5.3

for you to fetch changes up to dec43da46f63eb71f519d963ba6832838e4262a3:

  fpga: altera-ps-spi: Fix getting of optional confd gpio (2019-08-18 17:40:02 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.3

A single fix for the altera-ps-spi driver that fixes the behavior when
the driver receives -EPROBE_DEFER when trying to obtain a GPIO desc.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Phil Reid (1):
      fpga: altera-ps-spi: Fix getting of optional confd gpio

 drivers/fpga/altera-ps-spi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)
