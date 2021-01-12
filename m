Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3C2F28CD
	for <lists+linux-fpga@lfdr.de>; Tue, 12 Jan 2021 08:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391980AbhALHPj (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 12 Jan 2021 02:15:39 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34781 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391979AbhALHPj (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 12 Jan 2021 02:15:39 -0500
Received: by mail-pl1-f181.google.com with SMTP id t6so937928plq.1
        for <linux-fpga@vger.kernel.org>; Mon, 11 Jan 2021 23:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1CO7Yp6bkgeTi34ymuK73ENntn0S9E+sDd4Nu3+Y9lI=;
        b=RaPojpQtun3Mzx3zECuZwT8syoTWOEJziV825dAsYn1n4V32sN2PJXQJ0CrS0Tzvim
         uUaIQbhPuhrTDrPp7aj4zblE3MPNXerbfQ7t9S6ZNTLCt0ynM6KRSShQ/fm+3V6MgLUK
         3GY8p0Y8bmOYp4N0uUzf94kFX/FbuFB+ILjivHrls05OiiiE7Oyg0XIlyrUT0IFEijO3
         PfqCBxJdRbMfYexm/j9WFtRnh21/5Du3/gy8izGud/RijHndrgYqa1Bi3IdIs2t/BBKt
         mmB6AGfnCqOMu+LswTLTclVS7nJj0PLnS/YmKfSAYYp5OF3sGMI+//PhHaPF4k/UtmI7
         7bbw==
X-Gm-Message-State: AOAM530GSq/WbwOurCp3cJXsa46rMs9pGEOJKzqUb09Xq7zWfxqUZcXy
        6D+3xtLs1rJfd8q1Q2g08RI=
X-Google-Smtp-Source: ABdhPJyfwdh0mo6Oq9Af/Z/pAA5WTKZl+zLKQtob876rdKmsXtlP2QdwqgyGhuCm0GLExt+h/lSMqQ==
X-Received: by 2002:a17:902:bf44:b029:da:d140:6f91 with SMTP id u4-20020a170902bf44b02900dad1406f91mr3434282pls.51.1610435698073;
        Mon, 11 Jan 2021 23:14:58 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i67sm1936444pfc.153.2021.01.11.23.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 23:14:57 -0800 (PST)
Date:   Mon, 11 Jan 2021 23:14:55 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, trix@redhat.org, moritzf@google.com
Subject: [GIT PULL] First set of FPGA Manager changes for 5.12-rc1
Message-ID: <X/1Mb/9+Ln49Fdw8@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-cleanup-for-5.12

for you to fetch changes up to e41d4c011706c97f2faea6ef2e46e51f52d8f715:

  fpga: dfl: fme: Constify static attribute_group structs (2021-01-10 10:57:14 -0800)

----------------------------------------------------------------
First set of FPGA Manager changes for 5.12-rc1

This is the first set of changes for the FPGA Manager 5.12-rc1
mergewindow.

DFL:
- Minor cleanup, constifying a static attribute group

Core:
- Minor cleanup, using DEFINE_SPINLOCK over open coding it

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Rikard Falkeborn (1):
      fpga: dfl: fme: Constify static attribute_group structs

Zheng Yongjun (1):
      fpga: Use DEFINE_SPINLOCK() for spinlock

 drivers/fpga/dfl-fme-perf.c | 6 +++---
 drivers/fpga/fpga-bridge.c  | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)
