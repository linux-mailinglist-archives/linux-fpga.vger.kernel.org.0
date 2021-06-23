Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7A3B2032
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 20:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhFWS0j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 14:26:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhFWS0j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GrJNB3F5Xa+3Y8OXY7VwcTtiFdRpMIB1S8U9GBXw92s=;
        b=ZTi1HOZdEj0zI4aziqgNhdbPEd+nV67mxpcPrQw8WkQ/y1dQ48s8Wl4Ef9+wXh2vJcY+oX
        UJu01tI11QWJVnY6/Qfsooznuowvz8/mnK8iBrNTKCnfy3E/y0Z72yzZiF147LoM1BSWmZ
        WGxIv2Z/kjkgn/8PwGExsCF0pkaBenQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-4HBmKPU-OleIV7b8B8m1kQ-1; Wed, 23 Jun 2021 14:24:19 -0400
X-MC-Unique: 4HBmKPU-OleIV7b8B8m1kQ-1
Received: by mail-ot1-f70.google.com with SMTP id l13-20020a9d734d0000b02903db3d2b53faso1814814otk.6
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 11:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GrJNB3F5Xa+3Y8OXY7VwcTtiFdRpMIB1S8U9GBXw92s=;
        b=CldtbZheJAoOQVIMKHsLwdPP8SWoPg4fY3auW664D0VutmT7iwKYMlL9lVM+ClzOdE
         Xqc5gOzLTiNqmkSWtUcQCoMW27RGh+og2QyXuEeoSIdl0J7OogJc+wskNWmfweaaodw9
         YuFiAY7Kh58Efb747qV3YiN2IMGg4eqme+UrxgpAKwUZX40BZox82aE3BD/EAKIXlhxl
         wq828TmF6yhaqrpqIT+XjHd5qU+xW5wyUi8BGU0xA3UPI7KWSEjFvoeYjk/5GUqXN6Tn
         N8/jnf7rqjrIw0kJQx7girP8hSraER6O9WifcvIQn11EzqLQhrY0akDern/nVO4DS4TZ
         /wrw==
X-Gm-Message-State: AOAM530sfhT0/Ue03quAdwzZGcilZXCzLBbFv0DtEq4k/rl15qE8WYJT
        5TF4Bd04Jsu3wzO8BiLieaBP0Wd5UcwsJOTwAXIYdmOyvNZnp8qwWigrGiQspnVqvyI1Ey/yky6
        Sca/PjozjnwYQhObD1gX4lQ==
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr1114571otl.21.1624472659095;
        Wed, 23 Jun 2021 11:24:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg5ir0u+uONkcYSiNdhPznngImJRhHue1OFRj781vKuQhdCxHokiOVjGkujqp5MU0GiKAItw==
X-Received: by 2002:a9d:1b4f:: with SMTP id l73mr1114558otl.21.1624472658915;
        Wed, 23 Jun 2021 11:24:18 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:18 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 0/7] wrappers for fpga_manager_ops
Date:   Wed, 23 Jun 2021 11:24:02 -0700
Message-Id: <20210623182410.3787784-1-trix@redhat.com>
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

Changes from

v1:
  commit subject,log

v2:
  rebase to next-20210623

Tom Rix (7):
  fpga-mgr: wrap the write_init() op
  fpga-mgr: make write_complete() op optional
  fpga-mgr: wrap the write() op
  fpga-mgr: wrap the status() op
  fpga-mgr: wrap the state() op
  fpga-mgr: wrap the fpga_remove() op
  fpga-mgr: collect wrappers and change to inline

 drivers/fpga/dfl-fme-mgr.c   |   6 ---
 drivers/fpga/fpga-mgr.c      | 102 +++++++++++++++++++++++------------
 drivers/fpga/stratix10-soc.c |   6 ---
 drivers/fpga/ts73xx-fpga.c   |   6 ---
 drivers/fpga/zynqmp-fpga.c   |   7 ---
 5 files changed, 67 insertions(+), 60 deletions(-)

-- 
2.26.3

