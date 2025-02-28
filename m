Return-Path: <linux-fpga+bounces-1067-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA2A495B5
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 10:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71BD316385F
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA3256C8D;
	Fri, 28 Feb 2025 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf/zCI9U"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2511DE4FA;
	Fri, 28 Feb 2025 09:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736061; cv=none; b=e2Z0e4BhBEtix7qPnxlNPjEDcp8IhQOIz4QCsgT0SoR9WbYw6b4A+kG9e7Y9YP+WbLxc5iESRxwtdo9Who8vC7jDgEwXbtOG9N3OVdQQpLZzQAW+18/glHah3mE0mTDd1HJS8FoMakRYFIPmVHMTjnrSCpSqFO4MHbu+iZfAqHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736061; c=relaxed/simple;
	bh=QYakFBEzWGJOW8oj2Cse/b47o6dWaHYM79yZLFoU59U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkz+A8L0NYanZlUlTJu3FV8+j1l4SYHiRiBruiWXFziOrT9VWs3Xu0AEfPS+8kYZ/HtzMpCrDmmWg/6YH4gaXUJ1JuWpH4EdUQcFmKWE8npfNi11bbnCpyI7mz5ph1nTgApHTeEKYPu1xJNVwU9Kvg4QMlJo7iIvNGXr3BHtbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf/zCI9U; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so3080033a12.1;
        Fri, 28 Feb 2025 01:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736057; x=1741340857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vDGMfbuMuR3kBQiI4rogi0ibRohl5mipY0hH/p5U0xU=;
        b=Jf/zCI9U26wkIdganPzairN3ySIE5k3Zg5Hvh1ymTYtCe1ghCHrFd4KS0eIgZE+cLL
         xADTZMlfQUTyInarCy9HOY/e6xuokJpgnmFQNPvC2BmpG8AauqeEbA/jNIb3Tq7LsUr3
         CsvOIZKxMr/y/88StC0QftN+xr35RyxDuuyhOLD7nuoSy5r7JNiU2lFsnYun3uEEn6Ib
         EqEVobl2nVDtZgbU9ioh/D8QiicG2dH4UMQia7cDsfa4tqecd3uWV4PsTFmtnWRZiDQZ
         kDLwy35VPA/xxt3HeJVNEh26rS/w0V/7zaYvKk7HG5ZHbOaOCQZJkjoA8ZqycbSMCU5t
         kIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736057; x=1741340857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDGMfbuMuR3kBQiI4rogi0ibRohl5mipY0hH/p5U0xU=;
        b=jtglKm/LI7MH7LZMW5e42CWEX0VUPh3Mi3I43aZcf8mNc/3GdlaIBvZbNaJ2vBfukf
         7OeGALTpx0FFlBTBWeFWAoXkmSVkkAndicrEeVCYzS7qMGeg3d4zNQsnh/XYAxXZluFg
         ap5+/ofq3DyTbTQGD8d8FU4q65uKrulNyun7Zz1UNgKewJZ5h2GnNy2HXaIh9J8iBRQt
         oai4pOK4n/1TPMOesx05tqhQQBvo4KLHQlkk8Fc7iDIq9jClvDZKF4z+uPA2JFHqFjcE
         z48Jqdzix+4hIBK91Q5zq2nppfiIN2GbZSjCP19FfNdMxYm16+AzMM8szkq5YL3QulFL
         Bp6w==
X-Forwarded-Encrypted: i=1; AJvYcCW0woCPYYDfT2vB69W9/CsJ5oQuAwhhM8YPAfI5n5guqAlbazHAVW0wY/sxF3mcQkGEoUviZNInbw+vRgTE@vger.kernel.org, AJvYcCWSYY0gptNxlTtoyqR7Tzr6wu9FqbHNtBODoq59DqSAe7VUtcrcCPJs4DWh1q49QwoL9jD3VIYYrM1R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxq1VHk2wux2u6MhTGVJ7qFm0Ij2IqRz2pkdcKJEn/BR7xVuOM
	3PYzF0XNo85dBLWwy9FWSuLom6oUBURYn9c2xtd9paMPstSok34WBQn27oBC
X-Gm-Gg: ASbGncu4kPiEagXtWSIsRXa6oJmud34hf0plLz7qAezf/XVoFejl8jbLYbCrv+9S/2v
	2kXK7VTfcqpLelR+IBjwdOHNtsmoYJ9wbYHnt8hwD5WL3KYfypJxx6etgRr3lF661yvfPlZMrJo
	c8F1rxed4ZkENuTcMP77iNeXnOGiMavddaY2HTihci1yPezfdOjclu+Cz8ZkPKSaA49NLQ//Zaz
	8v81lZPQrzwpiqjOjnP/bcKaF0LJPY0OIXApJmVr99eHVLK4OXLh3Trxy2yd+YbTAWc5VBi8JFG
	yemGBpAIHSeIQHfwIkqMfUV2OzP0y4BQhNlLKKJd1JZKbX2ObFbe2vgFxG1n7/uxGP1N8i8eJnn
	NCAOPG0o/U93MfsrQR4xfPA==
X-Google-Smtp-Source: AGHT+IEMlhGXm6Y/JnTOzt9A8nMyh8wvCRZshv6TEnEsqVpAdgmtrARjWrSl+UYBxnKInte+nizI7g==
X-Received: by 2002:a17:907:7f91:b0:ab7:c358:2fec with SMTP id a640c23a62f3a-abf25da05d8mr307714266b.5.1740736056852;
        Fri, 28 Feb 2025 01:47:36 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f0300004dcedf2362c26f55.dip0.t-ipconnect.de. [2003:eb:5f03:0:4dce:df23:62c2:6f55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1a60de5esm209289566b.100.2025.02.28.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:47:36 -0800 (PST)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Ian Dannapel <iansdannapel@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [v4 0/3] Add Efinix FPGA SPI programming support
Date: Fri, 28 Feb 2025 10:47:29 +0100
Message-ID: <20250228094732.54642-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

This patch series introduces support for Efinix FPGA devices
through SPI-based programming.

Currently, only Trion devices are tested. Topaz and Titanium series are 
theoretically supported because of the similarity with Trion, but the
driver is only documentation based.

Changes since v3:
- major rework on the driver spi write approach
    - indirect CS assert using spi_transfer instead of duplicating the
  SPI controller property
  - locked SPI bus transfer to avoid possible conflicts with other
  devices on the bus
- file name and compatible strings renamed to better match device
- minor improvements/fixes


Ian Dannapel (3):
  dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
  dt-bindings: fpga: Add Efinix SPI programming bindings
  fpga-mgr: Add Efinix SPI programming driver

 .../devicetree/bindings/fpga/efinix,spi.yaml  |  81 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/fpga/Kconfig                          |   7 +
 drivers/fpga/Makefile                         |   1 +
 drivers/fpga/efinix-spi.c                     | 212 ++++++++++++++++++
 5 files changed, 303 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fpga/efinix,spi.yaml
 create mode 100644 drivers/fpga/efinix-spi.c

-- 
2.43.0


