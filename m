Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A573A04B0
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhFHT5H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233989AbhFHT5G (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=SDRWthhL61IjPb9M8bYDVk+PSOrMVCZU7hF3r5pwUytroEJHPRwMOblYaz0e+LjH6zVdRy
        MibAQBpXSDkueatIfIH48PYLYfs7/YfUdjzfkMstIWVO0OHI/sxf/ejuD55ON7Mce5/a6T
        +wVdC5rdccI5NMxZyNSWb5N6VP24vNA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-sPSQp9gCNiaqRSTJlZpZlA-1; Tue, 08 Jun 2021 15:55:11 -0400
X-MC-Unique: sPSQp9gCNiaqRSTJlZpZlA-1
Received: by mail-oi1-f200.google.com with SMTP id l1-20020a5441010000b02901ecd2ee1861so8844465oic.13
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/+OD7OvS+76UUwXsW39r3R0qwsEt76jbnvntpEkAgY=;
        b=N0eGBgmmZ7ZsgPqi5n82RxoYZwlL8rh2Mxz4REYUEpPmn8Dq+P6AiaCDhZ+EQvVGd/
         QXvpuuGkHWST8QIIwU3Wsoux7YYmJ+2EULkGqPW+UsU06q0vq+LLRLlDggR/BCSkUJnn
         9eF4OcQRV1XW5SrquMwKS+neyCzTFkbIHq18SL2coSWHTtbdNNxU7QAl5q88beflDAzv
         ZMsDsM2sP2tSlElKSxBFhAs9aVPnnbZYNn7HQPiEUqsc7ubWYPs9JKGEBgnwv3SHYRET
         OgSFU53batYyZrO7uuYri/x2MbSIDDaCv1TsG/OPDv3my85JyLE9byDzNMMvmIbQJVwB
         o7ig==
X-Gm-Message-State: AOAM533P6uEmQq3+ez3aaj4zi/9oBoXazxZDl1Tyfrz5WxSR+dEad1uM
        seJenSt1BTCZhrrNYI0MKIFUeTcgU5oNCW0v995Ek124ef3vGwf2Z+R/nE1qxUuLUJmcFVaINhJ
        lwlwJDBcozxcZ3rj9FTTcTA==
X-Received: by 2002:a4a:a843:: with SMTP id p3mr18458764oom.29.1623182111169;
        Tue, 08 Jun 2021 12:55:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7iFsOk+xHbLD3KsS/d+cS++jYnbcHd1SPwdO/kpmBt2w1RQcd/Tt8SvWaTnz4Ft10DJ6acg==
X-Received: by 2002:a4a:a843:: with SMTP id p3mr18458754oom.29.1623182110927;
        Tue, 08 Jun 2021 12:55:10 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:10 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/7]  wrappers for fpga_manager_ops
Date:   Tue,  8 Jun 2021 12:54:58 -0700
Message-Id: <20210608195506.3022550-1-trix@redhat.com>
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

v1: commit subject,log

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

