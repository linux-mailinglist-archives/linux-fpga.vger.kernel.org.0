Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4374C1F3FC7
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jun 2020 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgFIPsD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Jun 2020 11:48:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44760 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFIPsC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 11:48:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id r18so4204671pgk.11
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 08:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xkCzaihkRY4I2MM9xpjR+NNHS2QRjkGBcv6Fc7BR+mk=;
        b=J/NQjTfQ+hJz+kan1WusDwQGF4jicWqwZQrun/IhVb1Xh4Xb+jF99JAtcMpXICRQhW
         BWxFwneHQ6t0TNhXo4YxsdunFHTWKxdZ2gcOyKxXktkOiZeG0TZ4fT0MpAfDU39QgtsI
         Bvj9VMgUo2NBqmvZfwqkQivEI+zUbX0N9ov6Etu7W/UOltWbWxolgbHGjq21tw46LxHs
         8/HuX8TDPn5iTZMOP1q9o5acTne9cKpTE2dAxWn6/uVnLT+eI64x8ZZebBCOql4KryQ1
         KjE9Lt1VliE+CT5LiLgIbLM/pVFuTsdlnFcpEfaB26EMkeNQyzEy8+3RB7Ub1x/LoNnX
         yvMQ==
X-Gm-Message-State: AOAM532CBVKJYxR+WvtuYfFfX16ufn7NgaQ/1X1MhKcX+RFrsMG0ldIK
        0cXGYwd1++FQbR07pAy9Db8=
X-Google-Smtp-Source: ABdhPJwx5Xe4zpzh3hoy1hBB76Go2w/M38QHk0fmejm/CSxgcDd5pbCaHKEKNsoid4/B7/46rDl4Uw==
X-Received: by 2002:a63:7f09:: with SMTP id a9mr23243649pgd.400.1591717682272;
        Tue, 09 Jun 2020 08:48:02 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id s21sm6213204pgg.8.2020.06.09.08.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:48:01 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:48:00 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.8
Message-ID: <20200609154800.GA16679@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.8

for you to fetch changes up to 6a47d6efc6931b02d10163de2fb85ec9953c4f5e:

  fpga: zynqmp: fix modular build (2020-06-09 08:27:01 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.8-rc1

Here is one (late) fix for 5.8-rc1 merge window.

Arnd's change addresses a missing build dependency.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Arnd Bergmann (1):
      fpga: zynqmp: fix modular build

 drivers/fpga/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

