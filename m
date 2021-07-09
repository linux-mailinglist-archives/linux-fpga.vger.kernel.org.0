Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED373C2519
	for <lists+linux-fpga@lfdr.de>; Fri,  9 Jul 2021 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhGINp3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Jul 2021 09:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhGINp3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 9 Jul 2021 09:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625838165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=spNjQtptlEVcvrozmGO/HwieAqlxhlgOeqNnoaP4BpY=;
        b=Tdog0RHJg9yXq4pyHOpmw7wnLh4e8au/BLYmvKGO+d5mFsZlnyq7z9HQTbHsWOXMu4ADVU
        LRdEhjdgFmbeuS69gzt0apKVHgk9CYtQ5JaG1+liSrn7bgFG2aIbPehoQloFynMabQuTho
        vfy6bf+OJXIWPJMpIASOjjts4nw6g7o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-nhLDWVYYOTqO2zcn0URKug-1; Fri, 09 Jul 2021 09:42:44 -0400
X-MC-Unique: nhLDWVYYOTqO2zcn0URKug-1
Received: by mail-oi1-f200.google.com with SMTP id t22-20020a0568081596b029023a41b03dc9so6700791oiw.1
        for <linux-fpga@vger.kernel.org>; Fri, 09 Jul 2021 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=spNjQtptlEVcvrozmGO/HwieAqlxhlgOeqNnoaP4BpY=;
        b=NQs5WXkP5ooFRQHJvsq0iV+sAuqGngSq4kxrt+ZmKPOsk1FZGdVACkCIqRM5iNovMU
         RMN4CrMocrcl9l5HMJdP2WgZD2ZVkTrY3cXjaayyJJhixLq7+kw6zzRMBRW6YUhctVeQ
         nGn74yno5SxAPZuppLrzm2YHRNdLTuabl0hB8kqVQgt+Vl+v51pfGio1JishpKkZb7A8
         Dlsb6SWuf+I9zArsajs4MKVwouEsnUirAE7IivcUxZNfEXAAtdpuWf4AoVPbjYRgi2/R
         DZ5aE7uefjcuyt6we6wRbfi8yZr9MezdglHABS/8PnSuColfsVYF0UZQGFeRROk05Oi7
         jVoA==
X-Gm-Message-State: AOAM5303A19WdhSVKVUJy7RBxWlWXGk+SB9oX0KudAoLvSY5MSwKyUEr
        tEVD9Q3GkGK+/qqSSDINgbFV7Qajw3Cu6XS8r/uOy6SK6tB6iS8sDEONQG6JQwxcD7vZKnXWqsv
        OukiGKMYjhkJfcdHsSOP0gA==
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr8090792oiv.112.1625838163812;
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/AJPAkUCZeXsxN5RuvbhEljezHAASCYfU2JIHa1+Afjzzn229yEybXEiXgtKE1cfhbxzfzw==
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr8090778oiv.112.1625838163596;
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id j23sm1215948oie.9.2021.07.09.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 06:42:43 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, corbet@lwn.net, hao.wu@intel.com
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/4] fpga: fpga-mgr: move compat_id from fpga_mgr to dfl
Date:   Fri,  9 Jul 2021 06:42:24 -0700
Message-Id: <20210709134229.2510349-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A followup to
https://lore.kernel.org/linux-fpga/aa06a7ca-eff3-5c0d-f3b0-f1d9ddb74526@redhat.com/
The current storing of compat_id in fpga_manager is dfl specific.
This makes the refactoring of the release()'s complicated because there
is a dfl specific flavor of register().

Keeping the compat_id sysfs abi, each implementation through the new
compat_id_show() fpga_region op can print out whatever value they need
to the sysfs.  Currently only dfl does.

Since there are now two ops for fpga_region, give fpga_region its
own ops table.  Add a wrapper for get_bridges().

Changes from
v1
  Completely written to keep sysfs abi

Tom Rix (4):
  fpga: region: introduce fpga_region_ops
  fpga: region: introduce compat_id_show op
  fpga: dfl: implement the compat_id_show region op
  fpga: remove compat_id from fpga_manager and fpga_region

 Documentation/driver-api/fpga/fpga-region.rst |  6 ++-
 drivers/fpga/dfl-fme-mgr.c                    | 23 ++++++-----
 drivers/fpga/dfl-fme-pr.c                     |  2 +-
 drivers/fpga/dfl-fme-region.c                 | 21 +++++++++-
 drivers/fpga/dfl.h                            | 14 +++++++
 drivers/fpga/fpga-region.c                    | 40 ++++++++++---------
 drivers/fpga/of-fpga-region.c                 |  6 ++-
 include/linux/fpga/fpga-mgr.h                 | 13 ------
 include/linux/fpga/fpga-region.h              | 26 +++++++++---
 9 files changed, 99 insertions(+), 52 deletions(-)

-- 
2.26.3

