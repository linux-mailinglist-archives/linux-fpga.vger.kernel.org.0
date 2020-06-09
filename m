Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9581F3B4E
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jun 2020 15:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgFINCg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Jun 2020 09:02:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47832 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728162AbgFINCf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 09:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591707754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=FPqVUb4/G3dJw/PtAdVqksI7+tWZ208hDHvS1pR5D1/4AvrXQxi0/7wGSL2XAsc2rz/7Fy
        fbD5o/a8wTMkBDmUMa3/cE5ywrnsagWav5N38sxMrYn6rkcA1fx33hh6KLfn+ldA+EoALD
        VVifK1DdiHxafrEGsxQYVyZLDSI0Ss4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-FxuGTydHOQa0dtCNH1I6ow-1; Tue, 09 Jun 2020 09:02:27 -0400
X-MC-Unique: FxuGTydHOQa0dtCNH1I6ow-1
Received: by mail-qt1-f197.google.com with SMTP id c22so17029235qtp.9
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 06:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QvkO2PPp+zFnnylyA9/RHaMuHI9iwBcF6vd6fIsDp3k=;
        b=anP3Fpus6xyj0Xr0HSksc6TVAR3iP9EhkT1VTz4aAdGYBGyCsf0h/gMyG4ftL8uPi9
         gpupptX0IzFaWLsWDs4MjPEUbvdqU3O3Hc9yoUPlHi2e6F7ohoQEke545rsMSfhOba/I
         KRJe26jqB83AfnMy9d7xZM7vtwAlG6GJyxqTb4zwmWLiw/+DrbjnEvul6+pfZTdr1DCU
         3aJCGPNHlBjb/pQuVfa+rfaalsdXK+SfBjycQf8NxEsO9Rm2raIi5iHK7Iwa2BDX3Xum
         mjGo+eAkBjzUsFDv7/+ITvQ5oxhCIhXPnJrWkGAGGiv2Sqm6leitwdI67eCqY5dMbhkK
         /65w==
X-Gm-Message-State: AOAM5302UQ9gYBnnjc1g7oPDR/gE0vWtFJWtE5po9PUH0ugzkNlqCWA9
        nSbCqt08lOZPUOaoI/P3iL1bBnMOzNgkQSxLbVgRzItHe+ZSNrF0qC0PscbKb9srej5HmdUqf1X
        AFGqUQfHRn2bzTLBYxtkjjw==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27676980qke.381.1591707746705;
        Tue, 09 Jun 2020 06:02:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeetGPEU0xF9HLprMg4MvSdl54Lp4Jsvbf7QFI0FFyJ0mJJTghbDKHUiCqj2qRDoXcVNxScQ==
X-Received: by 2002:a37:9e10:: with SMTP id h16mr27676931qke.381.1591707746339;
        Tue, 09 Jun 2020 06:02:26 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m7sm9635939qti.6.2020.06.09.06.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:02:25 -0700 (PDT)
From:   trix@redhat.com
To:     linux-fpga@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 0/1] selftests for drivers/fpga
Date:   Tue,  9 Jun 2020 06:02:07 -0700
Message-Id: <20200609130208.27390-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

repo : linux-next
tag : next-20200608

Start applying selftests to drivers/fpga.

While testing out this upcoming change on linux-fpga
'Add interrupt support to FPGA DFL drivers'

I did not see any existing fpga tests.
So I added one.


Tom Rix (1):
  selftests: fpga: dfl: A test for afu interrupt support

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

-- 
2.18.1

