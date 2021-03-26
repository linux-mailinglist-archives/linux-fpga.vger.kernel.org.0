Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B3434ACE3
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Mar 2021 17:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZQxw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Mar 2021 12:53:52 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45677 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCZQxn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 26 Mar 2021 12:53:43 -0400
Received: by mail-pf1-f176.google.com with SMTP id h3so5222927pfr.12
        for <linux-fpga@vger.kernel.org>; Fri, 26 Mar 2021 09:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hT0iNSAkhLI62R/MeGehw9j4pxyNSSw3PDfWGo0UYr0=;
        b=Klqc/5I/baCl1fEzhCEetYvpS20jxIJAJXO2UMIqkh15zSo5LHhri9g8neogQM4A8E
         5N+U1gtZlOinxyu+RUagyjQyyD0ekoZgfn4dz2mTc57pDL+364Vu4XLe7dCvUbcweBb5
         XOwby0MQv8RowqyHPadwyIKHXNEOvAq0e2/ht23g4y80YUOMxbF83ww41f1VB/XzIe1B
         prLHPXQDkdYh1Z06Xr0sEzrX+wgOzQ1ikDcf4kgtJ6Hj81DzNz2nv7FaNiyBRuf6PPJP
         7iY3ZwVofvTCMigNmofTbwNz9oUZQozUKar/tF8R3i/q93UDhNuDBKpUkN9ZKsWYxhWJ
         WsuQ==
X-Gm-Message-State: AOAM531l0pG3CdQe2IaQPfgVRlzxHucc2kwfAHA/1YWLPU2X6Ot//V+W
        jcjTPVqbZbWxVeNq/2or+5W6ELrnvLc=
X-Google-Smtp-Source: ABdhPJwCygBBcKY/jhYrHms3bzR3Yn7QWubJXZlHvL8sPW52rFB/OnMQDhVeNEUIK3q073wYEhOUGg==
X-Received: by 2002:a65:5289:: with SMTP id y9mr12212740pgp.447.1616777622594;
        Fri, 26 Mar 2021 09:53:42 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id c2sm9592266pfb.121.2021.03.26.09.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 09:53:41 -0700 (PDT)
Date:   Fri, 26 Mar 2021 09:53:40 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager fix for 5.12
Message-ID: <YF4RlBeQ7cWLVboz@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-fixes-for-5.12

for you to fetch changes up to 2e8496f31d0be8f43849b2980b069f3a9805d047:

  firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0 (2021-03-18 09:55:12 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.12

Richard's fix addresses an errornously flipped flag.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Richard Gong (1):
      firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0

 include/linux/firmware/intel/stratix10-svc-client.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
