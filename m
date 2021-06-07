Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9F39E541
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 19:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFGR0W (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 13:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35261 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230209AbhFGR0V (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 13:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TEP31TFdWd4l/tTP+PI0xsmjj+INe8K7ttjcjq53ptQ=;
        b=g2ureQQjw+Dcfvt1wVKyYoqTVv1DEmvRSq3raLwRfrP04yPt/2lWUn5onsj1tnq8FrXIoe
        UNK+reGXjkVlYQTK5gRHHRF4QhtVglUrN0MoHZnSKv6ODkz80Spqd4uzExvx1adv05awNn
        JZYe2+8D8K7tAuJbe4JxznW6mEjwURQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-L3-VE0pJNritzz3DlnxqzA-1; Mon, 07 Jun 2021 13:24:29 -0400
X-MC-Unique: L3-VE0pJNritzz3DlnxqzA-1
Received: by mail-oo1-f70.google.com with SMTP id b3-20020a4ab4830000b029020d5d68e38dso11469138ooo.21
        for <linux-fpga@vger.kernel.org>; Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEP31TFdWd4l/tTP+PI0xsmjj+INe8K7ttjcjq53ptQ=;
        b=kp4L2YVnrYrlt/vjOLnURe/0/UsfxG4j49nm9Me6CeOnY6d3j3JELgRKZp7ttGya/U
         sdrLGZ1z4Y5qhuemN3TjFal5/s8oaG2MKcTlEr7Acq8RExTAQfgQLqR8H1SRHKdt5AIG
         mkUt2NpigIkw3ZIvCcu5a7jfuMmBgJFzrE4+uq6xPAmaCAm7l1x5fxuPu4IGG26n5Dz0
         MGb9x+YjuJZkDaG/I+hS/NtRx6cj2NbBqM1k3k4iM1wRTxPly7eGiE12kIPAh/ZLc6k2
         0X+7dgMb+33/uGUxH6B3JHwEUa8iUtXZ/sL+UZfdqeMRKZrVJaA+sq4YP9ekfdhA0yZF
         tEkA==
X-Gm-Message-State: AOAM5328X3z6JXa7nq+lW5ZJLLZujbnuxKGwcQNniEDIOgSvBsAYSWW3
        dNQAZJlJVPmkAV8i7WJS5CcldGdR0tf1JtBTIQtVV7WygVclGRnDk6Yy/qe44WzUuriYMvlOMuL
        nbOvz5ktroBPePNvFoSAZzg==
X-Received: by 2002:a05:6830:200b:: with SMTP id e11mr14860937otp.349.1623086668182;
        Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZaUyERwELD4Yo3dxSCuUEjYFdaNad6e8SmjPnerQlkCLYK3J0lULnWCzJzpfF2wyloptH9Q==
X-Received: by 2002:a05:6830:200b:: with SMTP id e11mr14860925otp.349.1623086668040;
        Mon, 07 Jun 2021 10:24:28 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:27 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 0/7] fpga: wrappers for fpga_manager_ops
Date:   Mon,  7 Jun 2021 10:23:55 -0700
Message-Id: <20210607172402.2938697-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

As followup from
https://lore.kernel.org/linux-fpga/06301910-10a1-0e62-45a0-d28ab5a787ed@redhat.com/

Boards should not be required to have noop functions.
So improve or create fpga-mgr wrappers for the fpga_manager_ops.  
Remove the noop functions.
Refactor fpga-mgr to use the wrappers.

write_sg op was not wrapped on purpose.  Its checking / use in
fpga_mgr_buf_load_sg() did not warrant a wrapper.

Tom Rix (7):
  fpga: wrap the write_init() op
  fpga: make write_complete() op optional
  fpga: wrap the write() op
  fpga: wrap the status() op
  fpga: wrap the state() op
  fpga: wrap the fpga_remove() op
  fpga: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

