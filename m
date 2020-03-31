Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4F198AAD
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Mar 2020 05:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbgCaDzD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 30 Mar 2020 23:55:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42448 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCaDzD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 30 Mar 2020 23:55:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so9681353pfa.9
        for <linux-fpga@vger.kernel.org>; Mon, 30 Mar 2020 20:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=DpMo4ZjYbnfatwJxfyc9tZOPa6iLWb8xYgZaRI4cfOk=;
        b=WSj/6pWoDwHoZsRwM9W1vxmoHdggdd5c5g/XyMnKr0ia/OBz7QjCunTmmZdNLhqc0H
         PE0s98ypeQhdh+qpmx7QFwUTORb1KfWrLpzGJZ8hogzM3mtyi49UmkiB6s1yK0eK6APG
         tLUd2LorkKgNy5smoP++I0XyYYBKMh4cGm7n1qN6aTTk1SM777GqpBl10ASOLpRFslOy
         /BQ4ByjitoXx7zSEsIxNGpYcEtXOqtV47QrMB89BYoGmdecghAfrEikv7jT2/V7GRZZO
         nc8WCtEvu341QT4AOYi4DVKwt1khNzJoUVqX2Y9kX988ztDoPxb+6m3yzh9ucdVcRuyb
         aALw==
X-Gm-Message-State: ANhLgQ2gV/sHQv3iGjTgQLIKaFGDfCc+mHOUKfgvRZOxat7t8n823b1j
        YsBLancBydzdXU7nWNUg1nQ=
X-Google-Smtp-Source: ADFU+vt7R11rqEb2kD7FswXyuwnvGR1DOdgoTLyACnPvyvjRb2XGsXnzcoNx17MacQNvPQ6c13bJww==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr16304489pff.307.1585626901868;
        Mon, 30 Mar 2020 20:55:01 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1160:3ae1:1f56:6f77:5f9e])
        by smtp.gmail.com with ESMTPSA id x4sm10179826pga.54.2020.03.30.20.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 20:55:00 -0700 (PDT)
Date:   Mon, 30 Mar 2020 20:54:59 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     moritzf@google.com, linux-fpga@vger.kernel.org
Subject: [GIT PULL] FPGA Manager (late) fixes for 5.7
Message-ID: <20200331035459.GA3472@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ fpga-fixes-for-5.7

for you to fetch changes up to 3c2760b78f90db874401d97e3c17829e2e36f400:

  fpga: dfl: pci: fix return value of cci_pci_sriov_configure (2020-03-30 20:45:30 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.7-rc1

Here are two (late) fixes for 5.7-rc1 merge window.

Xu's change addresses an issue with a wrong return value.

Shubhrajyoti's change makes the Zynq FPGA driver return -EPROBE_DEFER on

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Shubhrajyoti Datta (1):
      fpga: zynq: Remove clk_get error message for probe defer

Xu Yilun (1):
      fpga: dfl: pci: fix return value of cci_pci_sriov_configure

 drivers/fpga/dfl-pci.c   | 6 ++++--
 drivers/fpga/zynq-fpga.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)
